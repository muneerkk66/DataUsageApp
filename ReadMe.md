#  DataMobileUsageApp -  Singapore's mobile networks usage list from 2008 to 2018 App is written in Swift

## Features
** List of available Mobile Data Usage from Data.gov.sg
** Display Singapore’s mobile networks from 2008 to 2018.

## Requirements

**iOS 13.0+ / macOS 10.14.4
**Xcode 11+
**Swift 5+

 ## Architecture
 
 ** We have used MVVM Architecture. Model–view–viewmodel (MVVM) is a software architectural pattern. MVVM facilitates a separation of development of the graphical user interface – be it via a markup language or GUI code – from development of the business logic or back-end logic (the data model).

## Components
### ViewController
1. DataUsageVC 
   Show's the list of the Mobile Data usage details using the Data given from the server. All the data is given by DataUsageVM.
2. DataUsageQuarterVC 
   Show's the list of the Mobile Data usage for selected Year. All the data is given by DataUsageVM.
### ViewModel
ViewModel interacts with model and also prepares observable(s) that can be observed by a View. One of the important implementation strategies of this layer is to decouple it from the View, i.e, ViewModel should not be aware about the view who is interacting with.
1. DataUsageVM
       Here we have two Handlers which will provide the data to VM. 
       1. API Handler
           Which will provide the DATA from the server
       2. Data Handler
           Which will manage to manipulate the data and the main business logic will handle here.

### Views
 
1. DataUsageTableViewCell
     Custom tableView cell for Mobile Data Usage List
### NetWorkManager
this is the network layer create to handle the API calls. Every request will goes this layer. We have used Alamofire to handle API calls.
### CoreDataManager
This is the common class to save model to the Coredata. This also handle multiple context and so other core data operation.

### ThirdParties
1. Alamorfire
2.FittedSheet
all the license are mentioned in the Utilities/AppLicense.txt file

   
     

## How To Install
1. Go to project directory
2. install pod using cocopod App or terminal command
3.Open project Workspace then run the code.
