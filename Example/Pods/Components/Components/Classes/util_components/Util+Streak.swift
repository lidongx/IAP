//
//  NodeManager.swift
//
//  Created by lidong on 2020/11/27.
//

import UIKit

///Streak 设计原理
/// 传入Record数组 数据以天（日期）生成结点 保存在map中
/// 结点与结点之间通过prev,next 指针相连 方面于计算


///目前按照timeInterval 来计算连续天数
///这种有个弊端，用户切换时区,就会显示不同的天数
///
public protocol RecordProtocal{
    
    //时间戳
    var timeInterval:Double { get set }
    
    //记录的唯一识别标志
    var uuid: String { get set }
}

//streak 刷新的通知
public let noti_refresh_streak = "noti_refresh_streak"

/*
   Streak 支持通知回调，通知名为 NotificationName.refreshStreak
 */



class Streak {
    /// 只能调用一次，数据读取完成了之后，屌用该方法
    /// - Parameter records: 传入WorkoutRecord 数据
    static func start(records:[RecordProtocal]){
        StreakManager.shared.start(list: records)
    }
    
    
    /// 增加 WorkoutRecord
    /// - Parameters:
    ///   - record: WorkoutRecord
    ///   - isRefresh: 异步执行, 是否需要更新curStreak，bestStreak
    static func add(record:RecordProtocal, isRefresh:Bool = true){
        StreakManager.shared.add(record: record, isRefresh: isRefresh)
    }
    
    
    /// 移除一个WorkoutRecord
    /// - Parameters:
    ///   - record: WorkoutRecord
    ///   - isRefresh: 异步执行, 是否需要更新curStreak，bestStreak
    static func remove(record:RecordProtocal, isRefresh:Bool = true){
        StreakManager.shared.remove(record: record, isRefresh: isRefresh)
    }
    
    
    /// 得到当前的Streak
    static func getCurrent()->Int{
        return StreakManager.shared.curStreak
    }

    //得到最高Streak
    static func getBest()->Int{
        return StreakManager.shared.bestStreak
    }
    
    //得到连续天数>=14天的数量
    static func getFourteen() -> Int {
        return StreakManager.shared.fourteenStreak
    }
    
    //获取某一天所有的记录
    static func getWorkoutRecords(by dateString:String)->[RecordProtocal]{
        return StreakManager.shared.getWorkoutRecords(by: dateString)
    }
    
    static func setCallBack(_ callback:((_ curStreak:Int,_ bestStreak:Int)->Void)? = nil){
        StreakManager.shared.callBack = callback
    }
}

fileprivate class LinkNode{
    var key:String!    //结点key
    var time:Double!    //时间戳
    
    //结点包含记录数组
    var records = [RecordProtocal]()
    
    var next:LinkNode? = nil  //下一个结点
    var prev:LinkNode? = nil  //上一个结点

    init(time:Double) {
        self.time = time
        self.key = Date(timeIntervalSince1970: time).yearMonthDayString
    }
}

fileprivate class StreakManager {
    
    static let shared = StreakManager()
   
    var curStreak:Int = 0
    var bestStreak:Int = 0
    
    //连续天数>=14天的数量
    var fourteenStreak: Int = 0
    
    private var nodeDict = [String:LinkNode]()
       
    var callBack:((_ curStreak:Int,_ bestStreak:Int) -> Void)? = nil
    
    init(){
        registerNotification()
    }
    
    func start(list:[RecordProtocal]){
        //清楚数据 避免重复出现的异常问题
        nodeDict.removeAll()
        
        //排序
        var records = Array(list.reversed())
        records.sort { (item1:RecordProtocal, item2:RecordProtocal) -> Bool in
            return item1.timeInterval < item2.timeInterval
        }
        //生成结点
        generateNodes(records: records)
        
        //刷新curStreak bestStreak
        refresh()
    }
    
    func remove(record:RecordProtocal, isRefresh:Bool = true){
        let key = Date(timeIntervalSince1970: record.timeInterval).yearMonthDayString
        //查找结点
        if let node = nodeDict[key] {
            //结点中移除record
            if let index = node.records.firstIndex(where: { $0.uuid == record.uuid }) {
                node.records.remove(at: index)
            }
            //结点中没有record的时候，移除结点
            if(node.records.count == 0){
                removeNode(key: key, node: node)
                //刷新Streak
                finished(isRefresh: isRefresh)
            }
        }
    }
    
    //dateString 必须是年月日的时间格式yyyyMMdd 2022-09-12
    func getWorkoutRecords(by dateString:String)->[RecordProtocal]{
        if let node = nodeDict[dateString]{
            return node.records
        }
        return []
    }
    
    /// 添加Workout记录
    /// - Parameters:
    ///   - record: Workout Record
    ///   - isRefresh: 是否刷新curStreak bestStreak
    func add(record:RecordProtocal,  isRefresh:Bool = true){
        let key = Date(timeIntervalSince1970: record.timeInterval).yearMonthDayString
        //存在结点
        if let node = nodeDict[key]{
            node.records.append(record)
            node.records.sort { (res1, res2) -> Bool in
                let time1 = res1.timeInterval
                let time2 = res2.timeInterval
                return time1 < time2
            }
        }else{
            //创建结点
            makeNode(time: record.timeInterval, key: key, record: record)
            finished(isRefresh: isRefresh)
        }
    }
    
    fileprivate func finished(isRefresh:Bool){
        if(isRefresh){
            refresh()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// refresh curStreak best streak
    fileprivate func refresh(){
        DispatchQueue.global().async {
            let cur = self.calculateCurStreak()
            let value = self.calculateBestStreak()
            DispatchQueue.main.async {
                self.curStreak = cur
                self.bestStreak = value.0
                self.fourteenStreak = value.1
                
                Noti.send(noti_refresh_streak)
                self.callBack?(self.curStreak,self.bestStreak)
            }
        }
    }
    //到该结点的streak
    fileprivate func prevCounter(for resNode:LinkNode)->Int{
        var node = resNode
        var count = 0
        count += 1
        while node.prev != nil {
            count += 1
            node = node.prev!
        }
        return count
    }
    
    //计算当前的streak
    fileprivate func calculateCurStreak()->Int{
        var count = 0
        let key = Date().yearMonthDayString
        if let node = nodeDict[key]{
            count += prevCounter(for: node)
        }else{
            let key = prevKey(time: Date().timeIntervalSince1970)
            if let node = nodeDict[key]{
                count += prevCounter(for: node)
            }
        }
        if(count < 2){
            return 0
        }
        return count
    }
    //计算best 并且 streak >=14 的数量
    fileprivate func calculateBestStreak()->(Int,Int){
        var best = 0
        var set = Set<String>()
        var fourteenSet = Set<Double>()
        for key in nodeDict.keys{
            if(!set.contains(key)){
                set.insert(key)
                let node = nodeDict[key]
                let count = calculateNodeStreak(node:node!,set: &set,fourteenSet: &fourteenSet)
                if(count > best){
                    best = count
                }
            }
        }
        return (best,fourteenSet.count)
    }
    
    
    /// 计算一个结点的Streak
    /// - Parameters:
    ///   - node: 结点
    ///   - set: cunzhu
    /// - Returns: Steak number
    fileprivate func calculateNodeStreak(node:LinkNode,set:inout Set<String>,fourteenSet:inout Set<Double>)->Int{
        var head1 = node
        var head2 = node
        var count = 0
        count += 1
        
        //向下一个结点循环
        while head1.next != nil {
            set.insert(head1.next!.key)
            count += 1
            head1 = head1.next!
        }
        
        //向上一个结点循环
        while head2.prev != nil {
            set.insert(head2.prev!.key)
            count += 1
            head2 = head2.prev!
        }
        
        if count >= 14 && head2.prev == nil {
            fourteenSet.insert(head2.time)
        }
        
        if(count > 1){
            return count
        }
        return 0
    }
    
    
    /// 通过数组生成结点
    fileprivate func generateNodes(records:[RecordProtocal]){
        for record in records{
            let time = record.timeInterval
            //以时间的年月日作为Key
            let key = Date(timeIntervalSince1970: time).yearMonthDayString
            
            if let node = nodeDict[key]{
                //存在key加入record
                node.records.append(record)
            }else{
                //创建结点
                makeNode(time: time,key: key, record: record)
            }
        }
    }
    
    
    /// 创建结点
    /// - Parameters:
    ///   - time: 时间戳
    ///   - key: 结点Key   年月日字符串
    ///   - record: 锻炼记录
    fileprivate func makeNode(time:Double,key:String,record:RecordProtocal){
        let node = LinkNode(time: time)
        //结点中的数组保存数据
        node.records.append(record)
        //存储结点
        nodeDict[key] = node
        
        //查找下一个结点链接
        if let nextNode = nextNode(node: node){
            node.next = nextNode
            nextNode.prev = node
        }
        //查找上一个结点链接
        if let prevNode = prevNode(node: node){
            node.prev = prevNode
            prevNode.next = node
        }
    }
    
    
    /// 移除结点
    /// - Parameters:
    ///   - key: 结点key
    ///   - node: 结点
    fileprivate func removeNode(key:String,node:LinkNode){
        //结点断开与上一个结点的链接
        if let prevNode = prevNode(node: node){
            prevNode.next = nil
        }
        
        //结点断开与下一个结点的链接
        if let nextNode = nextNode(node: node){
           nextNode.prev = nil
        }
        
        node.prev = nil
        node.next = nil
        
        //移除结点
        nodeDict[key] = nil
    }
    
    //获取下一个结点
    fileprivate func nextNode(node:LinkNode)->LinkNode?{
        return nodeDict[nextKey(time: node.time)]
    }
    
    //获取上一个结点
    fileprivate func prevNode(node:LinkNode)->LinkNode?{
        return nodeDict[prevKey(time: node.time)]
    }

    //下一天的Key
    fileprivate func nextKey(time:Double)->String{
        let date = Date(timeIntervalSince1970: time+24*3600)
        return date.yearMonthDayString
    }
    
    //上一天的Key
    fileprivate func prevKey(time:Double)->String{
        let date = Date(timeIntervalSince1970: time-24*3600)
        return date.yearMonthDayString
    }
}

//Streak 通知
extension StreakManager{
    fileprivate func registerNotification(){
        NotificationCenter.default.addObserver(self,
            selector: #selector(applicationDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }
    
    //home 进入APP 刷新Streak
    @objc fileprivate func applicationDidBecomeActive(){
        DispatchQueue.global().async {
            let cur = self.calculateCurStreak()
            DispatchQueue.main.async {
                self.curStreak = cur
                Noti.send(noti_refresh_streak)
                self.callBack?(self.curStreak,self.bestStreak)
            }
        }
    }
}



/*
private func isSameDay(time1:Double,time2:Double)->Bool{
    let date1 = Date(timeIntervalSince1970: time1)
    let date2 = Date(timeIntervalSince1970: time2)
    
    let text1 = date1.yearMonthDayText()
    let text2 = date2.yearMonthDayText()
    
    if(text1 == text2){
        return true
    }
    return false
}

private func isNextDay(time1:Double,time2:Double)->Bool{
    let resTime1 = time1
    let resTime2 = time2 - 24*3600
    return isSameDay(time1: resTime1, time2: resTime2)
}

private func isPrevDay(time1:Double,time2:Double)->Bool{
    let resTime1 = time1
    let resTime2 = time2 + 24*3600
    return isSameDay(time1: resTime1, time2: resTime2)
}
*/
