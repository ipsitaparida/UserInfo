//
//  ViewController.swift
//  FindUserGrp
//
//  Created by Ipsita Parida on 21/05/19.
//  Copyright © 2019 Ipsita Parida. All rights reserved.
//

import Cocoa
import OpenDirectory
import SystemConfiguration

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        do{
            // Create Net Config
            let net_config = SCDynamicStoreCreate(nil, "net" as CFString, nil, nil)
            
            //# Get Active Directory Info
            let ad_info = [SCDynamicStoreCopyValue(net_config, "com.apple.opendirectoryd.ActiveDirectory" as CFString)]
            let adDict = ad_info[0] as? NSDictionary ?? nil
            if adDict == nil{
                print("no ad")
            }
            
            //Create Active Directory Path
            let ad_path = "\(adDict?["NodeName"] as! String)/\(adDict?["DomainNameDns"] as! String)"
            print(ad_path)
            
            // Use Open Directory To Connect to Active Directory
            let s = ODSession.default()
            let node = try ODNode(session: s, name: ad_path)
            let query = try ODQuery(node: node, forRecordTypes: kODRecordTypeUsers, attribute: kODAttributeTypeRecordName, matchType: UInt32(kODMatchContains), queryValues: "ipsitaparida", returnAttributes: kODAttributeTypeNativeOnly, maximumResults: 0)
            let results = try query.resultsAllowingPartial(false) as! [ODRecord]
            var isAdmin = false
            for r in results {
                let attr = try? String(describing: r.values(forAttribute: "dsAttrTypeNative:memberOf"))
                print(attr)
                if attr?.contains("CN=Domain Admins") ?? false || attr?.contains("CN=Enterprise Admins") ?? false{
                    isAdmin = true
                }
                else{
                    isAdmin = false
                }
                print("User is admin :" , isAdmin)
            }
        } catch {
            print("Error")
        }
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

