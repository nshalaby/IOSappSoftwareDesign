# IOSappSoftwareDesign




#1.0: Introduction
Our design implements a phone application aimed to aid charity organizations in efficiently acquiring most needed donations. Our idea is to create an interface that connects organizations and the public, to allow people to view what requirements the organization needs. 


Initially our idea stemmed from the desire to reduce waste of food from restaurants and grocery stores and increase the donations made to charities (creating a win-win). As we researched this idea and talked to organizations and restaurants, we found this idea alone may not be the most substantial. 



Local downtown restaurants often do not have the extra supplies, making larger market restaurants the better target, however there are laws accompanying donating perishable food items in Newfoundland, that other areas of the world have changed to assist in this donation process. From the organizations we talked to, they said this idea is exactly what is needed and could be great for the general public and any restaurants wanting to participate to donate. Clothing and food are often donated by people and as such this target alone is a great starting step. 



We began our design by getting in touch with various charities located in St. Johns, including Bridges to Hope and The Gathering Place. These locations stated that this application could greatly help their organizations. They said often during various times they get an influx of the same type of clothing or food, and as such other areas of need are left neglected. 
The aim of this application is for organizations to register their information, and then maintain an updatable current requirements list. 


We want to set up this application in a way that makes it very easy for the general public to access this app and find this information. With what is required being given by the organization, people will be able to more accurately help various organizations, instead only donating to a choice charity, or always buying the same products to donate. 
The app will be composed of two different interfaces, one for the general public which will list all the availably registered organizations that then list their requirements. The second interface will be for charities. They will also have access to the same information as the general public, however they have the option of changing their information that they enter upon registration. 
#2.0: Project Design


#2.1: First Iteration


	Our first steps for our application will be to create the server and database that will house the information stored. The database will contain all registered information, meaning the information inputted by charities in order to register. This will include their own description, links to their webpage, their list of current necessities as well as log in credentials. 
	The database will also hold the registration information linked to general viewers, which will contain their log in credentials and notification settings. People will be able to set up notifications for certain organizations and save their preferences, which will be managed within the database. 
The server houses the application information, in which people will be able to access online and be connected with each other. The server is responsible for outputting all public information (charity profiles and requirement lists), and keeping it up to date with the database, meaning every time charity lists are modified, app users are automatically able to see the change on the application/server. 



Since our main focus for this first iteration is solely the backbone of the application, and neglects most of the design, aesthetic procedure, we are only going to implement the log in page for the app. 
This page will have a section for organizations to either choose to register or log in. There will also be a registration or log in for the general public, as well as a continue as guest option. The interfaces for the charities and public will not be shown, but any of these logs in buttons will lead to a frequently asked questions page of our application, which will be apart of the final design. 


#2.2: Final Demo


For our final demo, after the back-end database has been set up in our first iteration. This will then be time to design and fully implement the front-end user interface. We will decide on the logo, app icon, and how each page of the app is laid out. There will be two separate interfaces, one for the general public / restaurants and one for the charity organization. 
The log of the charity from our built database will be fully visible to both interfaces. There will be an option to “donate now” to a particular charity signing up to either drop off the food, or to schedule a pickup from the local charity. 
Usually if someone wants to donate to an organization, the process is calling up that local charity, being on hold for an amount of time to speak to the correct person, and then scheduling a time to drop off or arrange someone to pick up a donation depending on the quantity of the donation. At this point of the project we are aiming to have this process automated. The restaurant or grocery store can login to the app, pick the desired charity they wish to donate to, specify the quantity of the donation and schedule a time to drop off or pick up the donation. This will be based on the quantity of the donation, the hours the charity is open and the availability of a driver from each organization. All logging this info in their specific accounts.
Our final demo will show this process in an IOS app. We have also set up a time during midterm break to meet with bridges to hope’s manager to get feedback on what will be the most helpful to them as a donation app. Tailoring the app towards the charities experience will positively impact our design and we are open to changing the design based on the advice he provides.  


#2.3: Future Ideas


Our idea for this application originated with the idea of joining charities with restaurants as a mean to donate left over food to reduce waste and hunger collaboratively. This idea requires more investigation and collaboration with restaurants, however as an addition to our current app we considered adding a restaurant registration as well. 
The restaurant owner interface would be able to interact with organizations on the app to initiate food pick-up schedules. The restaurant would be able to offer food to any charity, in which the charity can then pick a mutual schedule time to pick up the food. The point of having the restaurant register instead of having a general account would be to allow them to receive a tax receipt from the charity, as a benefit to them. This feature would hopefully intrigue more restaurants to want to donate more. This could be automated even further, once the restaurant logs its surplus food, the charity and the donator can be automatically matched if both the charity and the restaurant have the same food log.


Depending on the popularity of the app and possible advertisement revenue, drivers could be hired to deliver food from restaurants to charities. This would work by hiring people through the app and then having them deliver the food. Instead of the charity choosing a scheduled time to pick up the food, they would be able to select a delivery option that would be free to them and the restaurant. 


In order to maintain drivers, their delivery can be rated by the charity, given the donation list from the restaurant and schedule delivery time. If there are missing supplies, or irresponsible drivers, they can be reported, and that user will not be hired again. The idea for this is to alleviate any inconvenience for the restaurant or charity and improve chances of donations. 
As well an in-app payment feature could be implemented, as to give people another, easier option to donate. Instead of clicking the donation link from the organization information profile, that takes the person to the charity website, a payment could be made within the app, onto the phone bill, that then gets sent to the organization. 
In addition to the information page of each charity, charities can also have the ability to post to a media feed linked with their account. Each organization page would have their general information, a list of their requirements, and then additionally their media feed. This could act as an extra way to spread word of charity events or donation goals, all accessible in the one location. Since people can receive notifications of chosen charities, these notifications would apply to the feed of the charity as well, informing people of anything that is new with the organization. 


#3.0: Conclusions


	Canada is among one of the largest food wasters on the plant. More than 2.2 million tonnes of edible food is wasted each year in Canada alone. In addition to economic costs (costing Canada an excess of $17 billion), food waste has substantial environmental impacts. This waste is due to many different events, the transport of food from farm to supermarket being number one (including the supermarket throwing away misshapen food), fish being caught and thrown back, produce being left in the field due to labour shortages, and consumers buying food and throwing away surplus, to name a few. Grocery stores on average throw away 43 billion pounds of food each year, and the average restaurant throws away 1.5% of their food daily (missing out on tax savings that could be earned from donations). A simple app solution to re-route the waste from restaurants and grocery stores may not provide a complete solution to this major issue, but it could be a steppingstone in the right direction. At the very least, providing awareness on these facts and statistics, and offering the information of what the food bank organizations are needing during different times of the year.

