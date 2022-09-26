//
//  IAP.swift
//  IAP
//
//  Created by lidong on 2022/8/31.
//

import Foundation
import RevenueCat
import Components

public typealias PurchasingCompletion = (_ isBuySucess: Bool, _ isActive:Bool, _ error: String, _ userCancel:Bool) -> ()

public class IAP : NSObject{
    public static var publicKey = "appl_ZkWIuFGjhwAjzjgyIgummYztjVl"
    
    public static var entitlementsIdentifier = "premium_access"
    public static let ActiveKey = "ActiveKey"
    
    public static let shared = IAP()
    
    public static func setup(){
        _ = IAP.shared
    }
    
    var offerings:Offerings?
    
    public override init() {
        super.init()
        config()
        
        fetchOfferings { b in
            /*
            let packages = self.packages(for: "paywall-1qump91r")
            
            for package in packages {
                print("price:\(package.storeProduct.price)")
                print("discounts:\(package.storeProduct.discounts)")
                print("unit:\(package.storeProduct.subscriptionPeriod!.unit)")
                print("value:\(package.storeProduct.subscriptionPeriod!.value)")

                if package.storeProduct.introductoryDiscount?.paymentMode.rawValue == 2{
                    print("freeTrial: unit:\(package.storeProduct.introductoryDiscount!.subscriptionPeriod.unit) value:\(package.storeProduct.introductoryDiscount!.subscriptionPeriod.value)")
                }
                print("================================")
            }
            */
        }
        
       // fetchOfferings()
        checkIsActive { isActive in
        }
        
        /*
        Purchases.shared.getProducts(["com.oneothergame.7min_butt.supporter_yearly_notrial"]) { products in
            print(products[0].localizedPriceString)
            
             let productType = products[0]
             print(productType.price)

            
            let price = products[0].localizedPriceString
            
      
        }
         */
        
        
        
    }
    
    private func config(){
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: IAP.publicKey)
        Purchases.shared.delegate = self
    }
    
    public func fetchOfferings( _ callback:((Bool)->Void)? = nil){
        Purchases.shared.getOfferings { [weak self] offerings, error in
            
            if let error = error as? RevenueCat.ErrorCode {
               print(error.errorCode)
               print(error.errorUserInfo)
                
                
            }

            guard let self = self else{
                return
            }
            DispatchQueue.main.async {
                if let offerings = offerings {
                    self.offerings = offerings
                    callback?(true)
                }else{
                    callback?(false)
                }
            }
        }
    }
    
    public func packages(for identify:String)->[Package]{
        if let packages = self.offerings?.offering(identifier: identify)?.availablePackages {
            return packages
        }
        return []
    }
    
    public func package(for offeringId:String,packageId:String)->Package?{
        let packages = packages(for: offeringId)
        for package in packages {
            if package.identifier == packageId{
                return package
            }
        }
        return nil
    }
    
    public func checkIsActive( _ completion: ((_ isActive:Bool) ->Void)? = nil){
        Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
            DispatchQueue.main.async {
                if purchaserInfo?.entitlements.all[IAP.entitlementsIdentifier]?.isActive == true {
                    // User is "premium"
                    userSaveBool(key: IAP.ActiveKey, value: true)
                    completion?(true)
                    return
                }
                userSaveBool(key: IAP.ActiveKey, value: false)
                completion?(false)
            }
        }
    }
    
    public func isActive()->Bool{
        if userGetBool(key: IAP.ActiveKey){
            return true
        }
        var b = false
        Purchases.shared.getCustomerInfo(fetchPolicy: .fromCacheOnly) { customerInfo, error in
            if customerInfo?.entitlements.all[IAP.entitlementsIdentifier]?.isActive == true {
                // User is "premium"
                b = true
            }
        }
        return b
    }
    
    public func buy(_ package:Package,completion:PurchasingCompletion?){
        Purchases.shared.purchase(package: package) {(transaction, customerInfo, error, userCancelled) in
            DispatchQueue.main.async {
                if customerInfo?.entitlements.all[IAP.entitlementsIdentifier]?.isActive == true {
                    // Unlock that great "pro" content
                    userSaveBool(key: IAP.ActiveKey, value: true)
                    showToast(text: "Buy finish")
                    completion?(true,true,"",false)
                }
                if userCancelled{
                    completion?(false,false,"",true)
                    return
                }
                if let errorText = error?.localizedDescription{
                    showToast(text: "Buy error:\(errorText)")
                    completion?(false,false,errorText,false)
                }
                completion?(false,false,"",false)
            }
        }
    }
    

    public func buy(_ offeringId:String, _ packageId:String,completion:PurchasingCompletion?)  {
        if let _ = offerings {
            if let package = package(for: offeringId, packageId: packageId){
                buy(package, completion: completion)
            }else{
                completion?(false,false,"Package is not exist",false)
            }
        }else{
            fetchOfferings { [weak self] b in
                if b{
                    self?.buy(offeringId,packageId, completion: completion)
                }else{
                    completion?(false,false,"Failed to obtain purchased product information",false)
                }
            }
        }
    }
        
    
    public func restore(completion:((_ success:Bool,_ messagae:String, _ title:String)->Void)?){
        Purchases.shared.restorePurchases { (purchaserInfo, error) in
            //... check purchaserInfo to see if entitlement is now active
            if error != nil{
                completion?(false,error!.localizedDescription,"")
                return
            }
            IAP.shared.checkIsActive { isActive in
                DispatchQueue.main.async {
                    let title = isActive ? "" : "No Subscription Found"
                    var message = ""
                    if isActive{
                        message = "Subscription successfully restored."
                    }else{
                        message = "You have not previously subscribed using this Apple ID."
                    }
                    completion?(isActive,message,title)
                }
            }
        }
    }
}


extension IAP : PurchasesDelegate{
    public func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
    }
    
    public func purchases(_ purchases: Purchases, readyForPromotedProduct product: StoreProduct, purchase startPurchase: @escaping StartPurchaseBlock) {
        
        startPurchase{ (transaction, purchaserInfo, error, userCancelled) in
            DispatchQueue.main.async {
                if purchaserInfo?.entitlements.all[IAP.entitlementsIdentifier]?.isActive == true {
                    // Unlock that great "pro" content
                    userSaveBool(key: IAP.ActiveKey, value: true)
                    showToast(text: "Buy finish")
                    return
                }
                if userCancelled{
                    return
                }
                if let errorText = error?.localizedDescription{
                    showToast(text: "Buy error:\(errorText)")
                }
            }
        }
    }
}
