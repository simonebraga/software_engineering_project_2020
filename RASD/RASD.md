[TOC]

# INTRODUCTION

## Purpose
<!--here we include the goals of the project-->

**SafeStreets** is a crowd-sourced application that intends to provide common users with the possibility to notify authorities when traffic violations occur. The main target of the application are violations that can be easily captured by a camera (like, for instance, parking violations).

The core of the application is **SafeReports**, which is the service that provides the common users the possibility to send a notification. To do so, they are requested to take a picture of the vehicle involved in the violation. Then the photo is checked and matched with some data captured at the moment (position, date and time) and sent to SafeStreets, which stores it to offer several services based on the analysis of these data.

The first one is **SafeAnalytics**, which provides the possibility to mine SafeStreets data to get information about violations. This service is offered to common users and authorities, that can access data with different restriction levels. Common users have access to anonymous and aggregate data concerning a selected zone. Authorities, instead, have access to unrestricted information on all the stored data.

SafeStreets must forward violation reports to Municipality Tickets Service to automatically generate traffic tickets. Data about issued tickets must be stored and analyzed to provide statistics through **SafeTickets**, which is another service thought to be enjoyed by authorities.

The last service provided by SafeStreets is thought for the municipality users. Its name is **SafeSuggestions**, and its purpose is to analyze the data collected by SafeStreets to suggest possible interventions aimed at reducing the incidence of accidents and violations in the most critical zones.

The purpose of the software is captured by the following goals:

* **G1**	SafeStreets must allow common users to send pictures of violations, including their date, time and position.

* **G2**	Common users must be allowed to access to anonymous and aggregated data.
* **G3**	Authorities must be allowed to access to all the data without restrictions.
* **G4**	SafeStreets must suggest possible interventions according to data about violations and accidents.
* **G5**	SafeStreets must be able to generate traffic tickets using MTS.
* **G6**	Data provided to generate traffic tickets must be checked to guarantee their reliability.
* **G7**	SafeStreets must provide statistics on issued tickets.

## Scope
<!--here we include an analysis of the world and of the shared phenomena-->

SafeStreets must interface with different types of users and information sources. In this context, it is very important to identify the placement of SafeStreets and its services with the entities of the scenario. To do so, we will refer to the following diagram. Afterward, every link between SafeStreets and the entities will be deeply analyzed to exhaustively describe the shared phenomena of the scenario.

<div style="text-align:center"><img src="resources/relationship_diagram.svg"/></div>

Two types of interactions can be defined:

* **Interactions with users** (blue arrows in the diagram)

* **Interactions with information sources** (red arrows in the diagram)

The main difference between the two types of interactions is the role of SafeStreets. In the interactions with users, SafeStreets has a passive role, in the sense that the activation of the interaction is triggered by a request coming from the user through one of the offered services. In the interactions with information sources, SafeStreets has an active role, in the sense that the activation of the interaction is automatically triggered by SafeStreets application to exploit back-end processes.

As mentioned before, services are exploited differently depending on the type of user that is enjoying the application. The type of the user is determined in the registration phase, which is different depending on this choice. Everyone can sign up as a common user. Instead, to sign up as an authority or municipality user, it is necessary to provide a unique disposable code, which assignment is not part of the application (SafeStreets must take care only of the verification of the provided code). The code is assigned only to users whose role declaration has been manually verified by a human operator. For this reason, the verification of authorities and municipality users is not considered in the registration phase.

Common users can notify a violation using SafeReports service. To do so, they are asked to select the type of violation and to take a picture of the violation where the license plate is visible. Then the picture is matched with some metadata, and users are asked to confirm the violation notification. Common users are also allowed to use SafeAnalytics service with restrictions, in the sense that they can access anonymous information about violations using some filters to select the zone and the time interval.

Authorities can access information about violations through SafeAnalytics service without restrictions. This means that they have access to all the violation reports, including pictures and license plates. Authorities are also allowed to access statistics on issued tickets by SafeStreets using MTS.

Municipality users are provided with SafeSuggestions service, which allows them to access suggestions on how to reduce the accidents and violations rate in the most critical zones. This is possible thanks to an internal analysis of SafeStreets on the stored data.

MTS is used by SafeStreets to generate traffic tickets. When a new violation is stored (after it is verified not to be a duplicated event), the violation report is forwarded to MTS which generates the traffic tickets and informs SafeStreets of the outcome. SafeStreets stores data about the issued tickets to provide statistics through SafeTickets service.

Municipality data about accidents is crossed with data collected by SafeStreets to identify possible unsafe areas and provide suggestions through SafeSuggestions service. SafeStreets periodically checks for new data to collect it and keep suggestions up to date.

This section was focused on the shared phenomena and the relationships between the entities of the scenario. A more detailed description of how every service is exploited can be found later in the document.

## Definitions, Acronyms, Abbreviations

### Definitions

* **User** is the consumer of the application. It includes common users, authorities and municipality users.
* **Common user** is the user type that everyone can sign up as. It does not require any kind of verification.
* **Authority** is the user type that authorities can get. It requires the verification of a disposable code.
* **Municipality user** is the user type that municipal employees can get. It requires the verification of a disposable code.
* **Timestamp** is a set of information about the time. It includes date (day, month, year) and time (hour, minute, time zone).
* **Violation report** is the unit of notification collected by SafeStreets. It consists of:
  * Picture of the violation
  * License plate of the vehicle involved
  * Type of the violation
  * Position of the violation
  * Timestamp of the notification
* **Equivalent events** are set of violation reports that satisfy the following conditions:
  * Same vehicles involved
  * Same types of violation
  * Position of the violations are different at most for 10 meters
  * Same dates of the violations
* **Activation code** [TOBEDEFINED]

### Acronyms

* **MTS (Municipality Tickets Service)** Service offered by the municipality to generate traffic tickets from information about the violations.
* **OCR (Optical Character Recognition)** Software that converts text scanned from a photo in a machine-encoded text.

### Abbreviations

* **Gn**  nth goal.
* **Dn**  nth domain assumption.
* **Rn**  nth requirement.

## Revision history
## Reference Documents
## Document Structure

**Section 1** is an overall introduction to the application. It includes the description of the main functionalities of the application, an analysis of scenarios in which the application works, the list of the potential users of the application with a concise description of the possible interactions and the definition of world-level goals. Also, some meta-information is included, like revision history, references, and explanation of the conventions occurring in the document.

**Section 2** includes the domain assumptions, a detailed description of the shared phenomena and a formal description of the domain carried out using UML class and state diagrams. The purpose of this section is to exhaustively describe the entities and the scenarios that the application must interact with, to be able, in the following sections, to focus only on the application requirements.

**Section 3** includes a detailed description of the application, useful for the development team. Here are classified the interfaces offered by the application, followed by requirements and constraints. More specifically, requirements are listed and matched with the domain assumptions to show how every goal is attained. In this section, the behavior of the application is described with the highest detail level through the use of sequence, activity, and use case diagrams.

**Section 4** includes the formal analysis carried out using Alloy as a modeling language. This section includes the model built focusing on the most critical aspects and the results of the analysis that proves the soundness and consistency of the model. Moreover, some worlds obtained by running the analysis are included to study in deep the most meaningful assertions.

**Section 5** includes information about the number of hours each group member has worked for this document.

# OVERALL DESCRIPTION

## Product perspective
<!--here we include further details on the shared phenomena and a domain model (class diagrams and statecharts)-->
## Product functions
<!--here we include the most important requirements-->
## User characteristics
<!--here we include anything that is relevant to clarify their needs-->
## Assumptions, dependencies and constraints
<!--here we include domain assumptions-->

* **D1**	Users do not modify reality to generate fake violation reports.

* **D2**	The violations notified by the users are coherent with the taken pictures.
* **D3**	There exists a finite set of violations.
* **D4**	There exists a finite number of possible interventions.
* **D5**	Devices running SafeStreets has a working camera.
* **D6**	The device camera is always safe (it is not possible to alter the data acquired by the camera).
* **D7**	Devices running SafeStreets are always able to get the timestamp.
* **D8**	Devices running SafeStreets are always able to detect the position with an error of at least 5 meters.
* **D9**	Internet connection is supposed to work whenever a user wants to use SafeStreets.
* **D10**	If OCR software returns a result, it is supposed to be correct.
* **D11**	If OCR software is not able to recognize a plate, it returns a special response.
* **D12**	A violation report is anonymous if and only if it consists only of the type of violation, position, and date.
* **D13**	Authorities and municipality users are previously verified.
* **D14**	MTS provides uninterrupted service.
* **D15**	MTS is always right when generating traffic tickets.
* **D16**	Data from the municipality is reliable.

# SPECIFIC REQUIREMENTS
<!--Here we include more details on all aspects in Section 2 if they can be useful for the development team-->

## External Interface Requirements

### User Interfaces
### Hardware Interfaces
### Software Interfaces
### Communication Interfaces

## Functional Requirements

### Users

![](resources/use_case_common_user.svg)

**Scenarios**

**S1**

Ted Mosby, a very honest architect , is tired of seeing cars parked in the red zone right in front of his
house. He told the problem to some police agents in the past but nothing happened. He wants
to report these violations again but he doesn't know how. Fortunately Barney, a public employee,
suggests him to download and use the new app Safestreets for reporting violations. After signing
up identifying himself as an user and inserting the email and password he can finally report the the violation. Mosby just need to activate the gps and the
internet connection and take a picture of the violation.He selects the type of violation from a predefined list. After that he is asked to confirm the plate of the violating
vehicle. He finally waits for the outcome of his violation report.


**S2**

Sheldon, a theoretical physicists, is currently studying the complexity theory. He thinks that in big
cities with a huge amount of traffic the number of traffic violations is much larger then in small
cities and villages. Since Sheldon moved to Milan recently he wants to know the areas of Milan
with the highest levels of traffic violations in order to avoid parking in dangerous places . Sheldon
knows about the SafeStreets app. He logs in inserting his email and password and makes a query for all the traffic violations
reported in the last month in Milan . The results are anonymized preserving the privacy of the
violators and then sent back to Sheldon. Sheldon can now park in safe areas.


| Name     | Sign-Up    |
| :------------- | :------------- |
|Actor| Common User |
| Entry conditions       | The user opens the app on his smart phone      |
| Events flow      | <ul><li>The user clicks on the sign up button</li><li>The user selects the option to identify himself as a common user.<li>The user fills the forms with his email and a password</li> <li>The system confirms his data</li><li>The system adds the new user to his data</li></ul>|      |
| Exit conditions     | <ul><li>The users is now registered and his account is registered to the system</li></ul>       |
| Exceptions     | <ul><li>The user has already an account. In this case the system suggests the user to click the login button instead</li><li>The user doesn't complete the data required for the registration. In this case an error is sent to the user asking him to complete the information</li><li>The users fills the forms with invalid data. In this case an error is sent to the user asking him to modify the invalid data</ul>   |


| Name |Login   |
| :------------- | :------------- |
|Actor| Common User |
| Entry conditions       | <ul><li>The users opens the app on his device </li><li>The user has already Sign up in the app</ul>      |
| Events flow      | <ul><li>The users presses the login button</li><li>The users types the email and the password</li><li>The system confirms the successful login</ul>     |
| Exit conditions    | <ul><li>The user is logged in and is able to use the SafeStreets services     |
| Exceptions      | <ul><li>The user types the wrong email or password. In both cases the system sends and error to the user asking him to try the email password combination again.        |

| Name |Report a violation   |
| :------------- | :------------- |
|Actor| Common User, OCR |
| Entry conditions       | <ul><li>The user has already done the login    |
| Events flow      |  <ul><li>The user takes a picture of the traffic violation.<li>The required metadata() is added automatically to the picture.<li> The user selects the type of violation from a list of violations.<li>The picture is sent to the OCR software to automatically scan and read the plate.<li>After receiving the plate from the OCR, the system asks the user to confirm the plate of the violation vehicle .<li> After the confirmation the system checks if the new violation is equivalent to an already stored one.<li>The system checks the integrity of the report <li> The systems stores the violation report if and only if the previous equivalence check returned a negative result and the integrity test was positive.  |
| Exit conditions    | The user receives a notification about the outcome of its violation        |
| Exceptions      | If the OCR is not able to read the plate then the system sends an error to the user and asks him to repeat the procedure .    |


| Name | Retrieve information  |
| :------------- | :------------- |
| Actors     | Common User, Google Maps  |
|Entry conditions| <ul><li>The user has already done the login<li>The user wants to retrieve information about traffic violations|
| Events flow | <ul><li> The user presses the button to start the query for the desired data.<li>The user inserts the geographical filter for the query.<li> The user inserts the time filter for the query<li> The system anonymizes the  information <li> The results are sent to the user
|Exit conditions | The results are displayed in a map exploiting Google Maps'API |
|Exceptions | |

![](resources/sequence_diagram_reports.svg)

![](resources/sequence_diagram_retrieve_information.svg)

### Authorities

**Scenarios**

* **S1** <!-- {access general data} -->

  [Name], a policeman, was notified about a stolen car. He gets the idea of looking for its possible traffic violations, in order to find it. He uses *SafeAnalytics* to retrieve information about it, searching for its license plate. [Name] discovers that the car is often parked on a reserved parking and finds the car in that location.



* **S2** <!-- {statistics from fines} -->

  [Name],  the police chief, needs to collect the more money he can from traffic tickets, to fund the construction of another police office. Thanks to *[GETTICKETINFO]* he is able to identify the areas in which more traffic tickets are generated and focus on that areas.

**Use case diagram**

<!--BEGINTODO-->

Authority -> Sign up

​		-> Login

​		-> Retrieve violations info 	-> Google Maps

​		-> Get tickets info 			-> MTS

<!--ENDTODO-->

**Use Cases**

| Name             | Sign Up                                                      |
| :--------------- | :----------------------------------------------------------- |
| Actor(s)         | Authority                                                    |
| Entry conditions | The authority opens SafeStreets on his device                |
| Events flow      | - The authority chooses the *sign up* option<br />- The authority selects the option to identify himself as authority<br />-The authority inserts the activation code<br />- The authority inserts his e-mail and password<br />- Authority confirms his data<br />- SafeStreets saves his data |
| Exit conditions  | The authority is registered and his data are saved           |
| Exceptions       | - An account with the same e-mail was already created. In this case SafeStreets warns the authority and asks to change e-mail or log in<br />- The activation code is not valid. The authority is asked to reinsert it<br />- The authority doesn't provide all the data. In this case the system asks him to insert them.<br /> |

| Name             | Login                                                        |
| ---------------- | ------------------------------------------------------------ |
| Actor(s)         | Authority                                                    |
| Entry conditions | - The user has opened the application on his device<br />- The user is already registered |
| Events flow      | - The authority chooses the *login* option<br />- The authority inserts his e-mail and password |
| Exit conditions  | The authority is identified                                  |
| Exceptions       | - The e-mail is not registered. The authority is asked to reinsert it or sign up<br />- The password is incorrect. The authority is asked to reinsert it |

| Name             | Retrieve violation info                                      |
| ---------------- | ------------------------------------------------------------ |
| Actor(s)         | Authority, Google Maps                                       |
| Entry conditions | The authority accesses the *SafeAnalytics* function          |
| Events flow      | - The authority selects the type of data he wants to receive<br />- Data requested are sent to the authority |
| Exit conditions  | SafeStreets displays the data. If a map is required, it is provided by Google Maps |
| Exceptions       | /                                                            |

| Name             | Get tickets info                                             |
| ---------------- | ------------------------------------------------------------ |
| Actor(s)         | Authority, MTS                                               |
| Entry conditions | Authority accesses the *[GETTICKETSINFO]* functionality      |
| Events flow      | - The authority selects the type of data he wants to receive<br />- Data requested are sent to the authority |
| Exit conditions  | Safestreets displays the data                                |
| Exceptions       | /                                                            |



### Municipality

**Scenarios**

* **S1**<!-- {get intervention suggestion} -->

  [Name], a municipality officer of the city of Milan, is looking for possible interventions in the city, to improve the mobility of his area. [Name] logs in SafeStreets and accesses *SafeSuggestions*. He is suggested to build a barrier near the sidewalk in [STREETNAME], due to the frequent parking violations that occur there.

(data from municipality)

**Use Case Diagram**

<!--BEGINTODO-->

Municipality -> Sign up

​						Login

​						Get intervention suggestion

<!--ENDTODO-->





<!--definition of use case diagrams, use cases and associated sequence/activity diagrams, and mapping on requirements-->

**G1)	SafeStreets must allow common users to send pictures of violations, including their date, time and position.**

* **R1**	When a picture is taken using SafeReports, a new violation record is generated.

* **R2**	When a new violation record is generated, the current position of the user is automatically detected and added to the report.
* **R3**	When a new violation record is generated, the timestamp is added to the report.
* **R4**	When a new violation record is generated, the photo is scanned by an OCR software to automatically detect the plate.
* **R5**	If the OCR software fails in detecting the plate, the user is notified about it and asked to repeat the procedure.
* **R6**	If the OCR software detects the plate, the user is asked to confirm the violation report.
* **R7**	If the user confirms the violation report, it is sent to SafeStreets.
* **R8**	SafeStreets stores the information about the violation only if there are no equivalent events already stored.

**G2)	Common users must be allowed to access to anonymous and aggregated data.**

* **R9**	SafeAnalytics allows common users to get information about violations in a specific zone and time interval.

* **R10**	SafeAnalytics anonymizes information before sending it to common users.

**G3)	Authorities must be allowed to access to all the data without restrictions.**

* **R11**	SafeAnalytics allows authorities to get unrestricted information about violations.

**G4)	SafeStreets must suggest possible interventions according to data about violations and accidents.**

* **R12**	SafeStreets must store data about accidents provided by the municipality when available.

* **R13**	SafeStreets must analyze collected data crossed with data from the municipality to suggest possible interventions.
* **R14**  SafeSuggestions allows municipality users to get suggestions provided by SafeStreets.

**G5)	SafeStreets must be able to generate traffic tickets using MTS.**

* **R15**	SafeStreets must forward every new stored violation report to MTS to generate traffic tickets.

**G6)	Data provided to generate traffic tickets must be checked to guarantee their reliability.**

* **R16**	When the users send a violation report, its integrity is checked.

* **R17**	If the integrity check is successful, the violation report is stored. Otherwise, the violation report is discarded.

**G7)	SafeStreets must provide statistics on issued tickets.**

* **R18**	When a new ticket is generated using MTS, ticket-related information is stored by SafeStreets.

* **R19**	SafeStreets must build statistics from stored data about issued tickets.
* **R20**	SafeTickets allows authorities to get information and statistics on issued tickets.

## Performance Requirements
## Design Constraints

### Standards compliance
### Hardware limitations
### Any other constraint

## Software System Attributes

### Reliability
### Availability
### Security
### Maintainability
### Portability

# FORMAL ANALYSIS USING ALLOY
<!--this section should include a brief presentation of the main objectives driving the formal modeling activity, as well as a description of the model itself, what can be proved with it, and why what is proved is important given the problem at hand. To show the soundness and correctness of the model, this section can show some worlds obtained by running it, and/or the results of the checks performed on meaningful assertions-->

# EFFORT SPENT
<!--in this section you will include information about the number of hours each group member has worked for this document-->

| Task                 | Braga | Calderon | Favaro |
| -------------------- | :---: | :------: | :----: |
| Introduction         |  10   |    5     |   5    |
| Product perspective  |       |          |        |
| Product functions    |       |          |        |
| User characteristics |       |          |        |
| Assumptions, dependencies and constraints |   5   |    5     |   5   |
| External Interface Requirements           |       |          |       |
| Functional Requirements                   |   5   |    5     |   5  |
| Assumptions, dependencies and constraints |   6   |    4     |   3   |
| External Interface Requirements           |       |          |       |
| Functional Requirements                   |   6   |    6     |  7  |
| Performance Requirements                  |       |          |       |
| Design Constraints                        |       |          |       |
| Software System Attributes                |       |          |       |
| Formal Analysis using Alloy               |       |          |       |

# REFERENCES
