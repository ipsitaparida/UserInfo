# UserInfo
This project aims to find out if a user is part of a particular group in Mac. I made a study of various methods we can use
to get a group details.

## Method 1 - Using command line utility

Using command line utility we can get a list of the groups present in the machine
```
groups
```
To find which groups a particular user is a member of, we can use the following command
```
groups <username>
```
## Method 2 - Using System Configuration framework

We can use this is multiple ways to get the requited information of a group.
Using ‘scutil’ will provide us with all the configuration present in the system.
```
$scutil
> list
```
We will get a list of the keys     
```    
>show com.apple.opendirectoryd.ActiveDirectory
Sample output-
<dictionary> {
  	DomainForestName : my.com
  	DomainGuid : 483D81Q5-V191-2K8M-2U7A-F1DABC0767DE
  	DomainNameDns : myad.com
  	DomainNameFlat : MYAD
  	MachineRole : 3
  	NodeName : /Active Directory/MYAD
  	TrustAccount : user-mbp$
	}
```
## Method 3 - Using System Configuration API
we can use the SystemConfiguration API to get this information through program. (Please refer the program).  
You need to know the appropriate key to get the value. Here our objective is to get details from AD server.
You can get the keyname from scutil. So the appropriate key will be "com.apple.opendirectoryd.ActiveDirectory"
Using "kODRecordTypeUsers" will provide us with user information as per the query set. the field "dsAttrTypeNative:memberOf"
will give us information of all the groups that this user is part of.
