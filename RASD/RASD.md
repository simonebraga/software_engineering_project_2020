[TOC]

# 1.  INTRODUCTION

## Purpose
<!--here we include the goals of the project-->

**SafeStreets** is a crowd-sourced application that intends to provide users with the possibility to notify authorities when traffic violations occur. The main target of the application are violations that can be easily captured by a camera (like, for instance, parking violations). SafeStreets intends also to provide users with the possibility to mine the stored information with different levels of visibility. Moreover, the application must cross the collected data with information coming from the municipality to provide suggestions on possible interventions to decrease the incidence of violations and accidents. In the end, the application must forward data about violations to generate traffic tickets, and must allow authorities to get statistics on issued tickets.

These requirements are exploited by developing several services:

* **SafeReports** allows common users to send violation reports.

* **SafeAnalytics** allows common users and authorities to mine stored information.
* **SafeTickets** allows authorities to get statistics on issued tickets.
* **SafeSuggestions** allows municipality users to get suggestions on possible interventions.

### Goals

The purpose of the software is captured by the following goals:

* **G1**	SafeReports must allow common users to send violation reports.

* **G2**	SafeAnalytics must allow common users to get anonymous data on violations.
* **G3**	SafeAnalytics must allow authorities to access to all the data without restrictions.
* **G4**	SafeSuggestions must allow municipality users to get suggestions on possible interventions.
* **G5**	SafeStreets must generate traffic tickets forwarding reliable data to MTS.
* **G6**	SafeTickets must allow authorities to get statistics on issued tickets.

## Scope
<!--here we include an analysis of the world and of the shared phenomena-->

SafeStreets must interface with different types of users and information sources. In this context, it is very important to identify the placement of SafeStreets and its services with the entities of the scenario. To do so, we will refer to the following diagram. Afterward, every link between SafeStreets and the entities will be deeply analyzed to exhaustively describe the shared phenomena of the scenario.

<br>
<div style="text-align:center"><img src="resources/relationship_diagram.svg"/></div>
<br>

Two types of interactions can be defined:

* **Interactions through services** (blue arrows in the diagram)

* **Interactions with resources** (red arrows in the diagram)

The main difference between the two types of interactions is the role of SafeStreets. In the interactions through services, SafeStreets has a passive role, in the sense that the activation of the interaction is triggered by a request coming from the user through one of the offered services. In the interactions with resources, SafeStreets has an active role, in the sense that the activation of the interaction is automatically triggered by SafeStreets application to exploit back-end processes.

Services are exploited differently depending on the type of user that is enjoying the application. The type of the user is determined in the registration phase, which is different depending on this choice. Everyone can sign up as a common user. Instead, to sign up as an authority or municipality user, it is necessary to provide a unique disposable code, which assignment is not part of the application (SafeStreets must take care only of the verification of the provided code). The code is assigned only to users whose role declaration has been manually verified by a human operator. For this reason, the verification of authorities and municipality users is not considered in the registration phase.

### SafeReports

SafeReports is the core of the application. It provides common users with the possibility to send a notification about a violation. To do so, they are asked to take a picture of the vehicle involved in the violation. Then the photo is checked and matched with some data captured at the moment (position, date and time). The user is asked to review and confirm the violation report that, in case of confirmation, is sent to SafeStreets, which stores it to offer several other services.

### SafeAnalytics

SafeAnalytics provides the possibility to mine SafeStreets data to get information about violations. This service is offered to common users and authorities, that can access data with different restriction levels. Common users have access to anonymous data concerning a selected zone. Authorities, instead, have access to unrestricted information on all the stored data.

### SafeTickets

SafeStreets uses Municipality Tickets Service (MTS) to generate traffic tickets. When a new violation is stored (after it is verified not to be a duplicated event), the violation report is forwarded to MTS which generates the traffic tickets and informs SafeStreets of the outcome. SafeStreets stores data about the issued tickets to provide statistics through SafeTickets service.
SafeTickets is a service that allows authorities to access data about tickets generated from SafeStreets using MTS. Authorities are also allowed to select some filters to get statistics and aggregated data.

### SafeSuggestions

Municipality data about accidents is crossed with data collected by SafeStreets to identify possible unsafe areas and provide suggestions through SafeSuggestions service. SafeStreets periodically checks for new data to collect it and keep suggestions up to date.
SafeSuggestions service is developed to municipality users. It allows them to access suggestions on how to reduce the accidents and violations rate in the most critical zones. Users can ask for suggestions using specific filters, depending on their intention to attend in a specific zone or to prevent a specific violation.

## Definitions and acronyms

| Subject                       | Acronym | Definition                                                   |
| ----------------------------- | ------- | ------------------------------------------------------------ |
| User                          | -       | The consumer of the application. It includes common users, authorities and municipality users. |
| Common user                   | -       | The user type that everyone can sign up as. It does not require any kind of verification. |
| Authority                     | -       | The user type that authorities can get. It requires the verification of an activation code. |
| Municipality user             | -       | The user type that municipal employees can get. It requires the verification of an activation code. |
| Timestamp                     | -       | A set of information about the time. It includes date (day, month, year) and time (hour, minute, time zone). |
| Violation report              | -       | The unit of notification collected by SafeStreets. It consists of:<ul><li>Picture of the violation<li>License plate of the vehicle involved<li>Type of the violation<li>Position of the violation<li>Timestamp of the notification |
| Equivalent events             | -       | Set of violation reports that satisfy the following conditions:<ul><li>Same vehicles involved<li>Same types of violation<li>Position of the violations are different at most for 10 meters<li>Same dates of the violations |
| Activation code               | -       | The code to be provided during the registration to get special permits on the account. |
| Municipality Tickets Service  | MTS     | Service offered by the municipality to generate traffic tickets from information about the violations. |
| Optical Character Recognition | OCR     | Software that converts text scanned from a photo in a machine-encoded text. |

## Revision history

| Version | Release date | Description   |
| ------- | ------------ | ------------- |

## Document Structure

**Section 1** is an overall introduction to the application. It includes the description of the main functionalities of the application, an analysis of scenarios in which the application works, the list of the potential users of the application with a concise description of the possible interactions and the definition of world-level goals. Also, some meta-information is included, like revision history, references, and explanation of the conventions occurring in the document.

**Section 2** includes the domain assumptions, a detailed description of the shared phenomena and a formal description of the domain carried out using UML class and state diagrams. The purpose of this section is to exhaustively describe the entities and the scenarios that the application must interact with, to be able, in the following sections, to focus only on the application requirements.

**Section 3** includes a detailed description of the application, useful for the development team. Here are classified the interfaces offered by the application, followed by requirements and constraints. More specifically, requirements are listed and matched with the domain assumptions to show how every goal is attained. In this section, the behavior of the application is described with the highest detail level through the use of sequence, activity, and use case diagrams.

**Section 4** includes the formal analysis carried out using Alloy as a modeling language. This section includes the model built focusing on the most critical aspects and the results of the analysis that proves the soundness and consistency of the model. Moreover, some worlds obtained by running the analysis are included to study in deep the most meaningful assertions.

**Section 5** includes information about the number of hours each group member has worked for this document.

**Section 6** includes the references to the tools used to draw up this document.

# 2.  OVERALL DESCRIPTION

## Product perspective
<!--here we include further details on the shared phenomena and a domain model (class diagrams and statecharts)-->

<br>
<div style="text-align:center"><img src="resources/class_diagram.svg"/></div>
<br>

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

# 3.  SPECIFIC REQUIREMENTS
<!--Here we include more details on all aspects in Section 2 if they can be useful for the development team-->

## External Interface Requirements

### User Interfaces
### Hardware Interfaces
### Software Interfaces
### Communication Interfaces

## Functional Requirements
<!--definition of use case diagrams, use cases and associated sequence/activity diagrams, and mapping on requirements-->

**G1)  SafeReports must allow common users to send violation reports.**
* **R1**	When a picture is taken using SafeReports, a new violation record is generated.

* **R2**	When a new violation record is generated, the current position of the user is added to the report.
* **R3**	When a new violation record is generated, the timestamp is added to the report.
* **R4**	When a new violation record is generated, the photo is scanned by an OCR software to automatically detect the plate.
* **R5**	If the OCR software fails in detecting the plate, the user is notified and asked to repeat the procedure.
* **R6**	If the OCR software detects the plate, the user is asked to confirm the violation report.
* **R7**	If the user confirms the violation report, it is sent to SafeStreets.
* **R8**	SafeStreets stores the information about the violation only if there aren't equivalent events already stored.

**G2) SafeAnalytics must allow common users to get anonymous data on violations.**
* **R9**	SafeAnalytics allows common users to get data about violations selecting zone, time and type of violation.

* **R10**	SafeAnalytics anonymizes information before sending it to common users.

**G3) SafeAnalytics must allow authorities to access to all the data without restrictions.**
* **R11**	SafeAnalytics allows authorities to get all the data stored by SafeStreets.

**G4) SafeSuggestions must allow municipality users to get suggestions on possible interventions.**
* **R12**	SafeStreets must store data about accidents provided by the municipality when available.

* **R13**	SafeStreets must analyze collected data crossed with data from the municipality to identify possible interventions.
* **R14**  SafeSuggestions allows municipality users to get suggestions provided by SafeStreets.

**G5) SafeStreets must generate traffic tickets forwarding reliable data to MTS.**
* **R15**	When the users send a violation report, its integrity is checked.

* **R16**	If the integrity check is not successful, the violation report is discarded.
* **R17**	SafeStreets must forward every new stored violation report to MTS to generate traffic tickets.

**G6) SafeTickets must allow authorities to get statistics on issued tickets.**
* **R18**	When a new ticket is generated using MTS, ticket-related data are stored by SafeStreets.

* **R19**	SafeStreets must build statistics from stored data about issued tickets.
* **R20**	SafeTickets allows authorities to get information and statistics on issued tickets.

### Use cases diagrams

#### Common users

![](resources/usecase_common_user.svg)

**Scenarios**

**S1**

Ted Mosby, a very honest architect , is tired of seeing cars parked in the red zone right in front of his house. He told the problem to some police agents in the past but nothing happened. He wants
to report these violations again but he doesn't know how. Fortunately Barney, a public employee,
suggests him to download and use the new app Safestreets for reporting violations. After signing
up identifying himself as an user and inserting the email and password he can finally report the the violation. Mosby just needs to activate the GPS and the
internet connection and take a picture of the violation. He selects the type of violation from a predefined list. After that he is asked to confirm the plate of the violating
vehicle. He finally waits for the outcome of his violation report.


**S2**

Sheldon, a theoretical physicists, is currently studying the complexity theory. He thinks that in big
cities with a huge amount of traffic the number of traffic violations is much larger then in small
cities and villages. Since Sheldon moved to Milan recently, he wants to know the areas of Milan
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
| Events flow      |  <ul><li>The user takes a picture of the traffic violation.<li>The required metadata() is added automatically to the picture.<li> The user selects the type of violation from a list of violations.<li>The picture is sent to the OCR software to automatically scan and read the plate.<li>After receiving the plate from the OCR, the system asks the user to confirm the plate of the violation vehicle .<li> After the confirmation the system checks if the new violation is equivalent to an already stored one.<li>The system checks the integrity of the report <li> The systems stores the violation report if and only if the previous equivalence check returned a negative result and the integrity test was positive.|
| Exit conditions    | The user receives a notification about the outcome of its violation        |
| Exceptions      | If the OCR is not able to read the plate then the system sends an error to the user and asks him to repeat the procedure .    |

| Name | Generates tickets     |
| :------------- | :------------- |
| Actor       | SafeStreets, MTS     |
| Entry condition | The system has validated and stored a new traffic violation report. |
|Events flow |<ul><li>The system forwards the violation report to MTS<li>MTS generates tickets from the violation report<li> MTS sends the results to SafeStreets |
|Exit conditions | The system stores data about issued tickets |
|Exceptions | If MTS is not able to generate the tickets then and error is sent to SafeStreets and no data about issued tickets is stored


| Name | Retrieve information  |
| :------------- | :------------- |
| Actors     | Common User, Google Maps  |
|Entry conditions| <ul><li>The user has already done the login<li>The user wants to retrieve information about traffic violations|
| Events flow | <ul><li> The user presses the button to start the query for the desired data.<li>The user inserts the geographical filter for the query.<li> The user inserts the time filter for the query<li> The system anonymizes the  information <li> The results are sent to the user
|Exit conditions | The results are displayed in a map exploiting Google Maps'API |
|Exceptions ||

![](resources/sequence_diagram_report.svg)

<br>

![](resources/sequence_tickets_generation.svg)

<div style="text-align:center"><img src="resources/sequence_diagram_retrieve_information_.svg"/></div>


#### Authorities

**Scenarios**

* **S1** <!-- {access general data} -->

  [Name], a policeman, was notified about a stolen car. He gets the idea of looking for its possible traffic violations, in order to find it. He uses *SafeAnalytics* to retrieve information about it, searching for its license plate. [Name] discovers that the car is often parked on a reserved parking and finds the car in that location.



* **S2** <!-- {statistics from fines} -->

  [Name],  the police chief, needs to collect the more money he can from traffic tickets, to fund the construction of another police office. Thanks to *[GETTICKETINFO]* he is able to identify the areas in which more traffic tickets are generated and focus on that areas.

**Use case diagram**

![](resources/authorities_usecases.svg)

**Use Cases**

| Name             | Sign Up                                                      |
| :--------------- | :----------------------------------------------------------- |
| Actor(s)         | Authority                                                    |
| Entry conditions | The authority opens SafeStreets on his device                |
| Events flow      | - The authority chooses the *sign up* option<br />- The authority selects the option to identify himself as authority<br />- The authority inserts the activation code<br />- The authority inserts his e-mail and password<br />- Authority confirms his data<br />- SafeStreets saves his data |
| Exit conditions  | The authority is registered and his data are saved           |
| Exceptions       | - An account with the same e-mail was already created. In this case SafeStreets warns the authority and asks to change e-mail or log in<br />- The activation code is not valid. The authority is asked to reinsert it<br />- The authority doesn't provide all the data. In this case the system asks him to insert them.<br /> |

| Name             | Login                                                        |
| ---------------- | ------------------------------------------------------------ |
| Actor(s)         | Authority                                                    |
| Entry conditions | - The authority has opened the application on his device<br />- The authority is already registered |
| Events flow      | - The authority chooses the *login* option<br />- The authority inserts his e-mail and password |
| Exit conditions  | The authority is identified                                  |
| Exceptions       | - The e-mail is not registered. The authority is asked to reinsert it or sign up<br />- The password is incorrect. The authority is asked to reinsert it |

| Name             | Retrieve violation info                                      |
| ---------------- | ------------------------------------------------------------ |
| Actor(s)         | Authority, Google Maps                                       |
| Entry conditions | - The authority is logged in SafeStreets   <br /> - The authority wants to collect data about violations       |
| Events flow      | - The authority accesses the *SafeAnalytics* function<br />- The authority selects the geographical filters <br /> - The authority selects the time filters <br /> - The authority selects the license plate filters <br />- Data requested are sent to the authority |
| Exit conditions  | SafeStreets displays the data. If a map is required, it is provided by Google Maps |
| Exceptions       | /                                                            |



| Name             | Get tickets info                                             |
| ---------------- | ------------------------------------------------------------ |
| Actor(s)         | Authority, MTS                                               |
| Entry conditions | - The authority is logged in SafeStreets <br /> - The authority wants to get information about tickets issued by SafeStreets      |
| Events flow      | - Authority accesses the *[GETTICKETSINFO]* functionality <br/> - The authority selects the geographical filters<br />  - The authority selects the time filters<br />  - The authority selects the license plate filters<br />- Data requested are sent by SafeStreets to the authority |
| Exit conditions  | Safestreets displays the data                                |
| Exceptions       | /                                                            |


**Sequence diagrams**

<!-- TODO sequence diagrams -->

![](resources/retrieve_violation_info_sequence_diagram.svg)

![](resources/get_tickets_info_sequence_diagram.svg)


### Municipality user

**Scenarios**

* **S1**<!-- {get intervention suggestion} -->

  [Name], a municipality officer of the city of Milan, is looking for possible interventions in the city, to improve the mobility of his area. [Name] logs in SafeStreets and accesses *SafeSuggestions*. He is suggested to build a barrier near the sidewalk in [STREETNAME], due to the frequent parking violations that occur there.

(data from municipality, send data to MTS) <!--TODO ? -->

**Use Case Diagram**

![](resources/municipality_usecases.svg)

**Use cases**

| Name             | Sign Up                                                      |
| :--------------- | :----------------------------------------------------------- |
| Actor         | Municipality user                                                  |
| Entry conditions | The municipality user opens SafeStreets on his device                |
| Events flow      | - The municipality user chooses the *sign up* option<br />- The municipality user selects the option to identify himself as municipality user<br />-The municipality user inserts the activation code<br />- The municipality user inserts its e-mail and password<br />- Municipality user confirms its data<br />- SafeStreets saves the data |
| Exit conditions  | The municipality user is registered and its data are saved           |
| Exceptions       | - An account with the same e-mail was already created. In this case SafeStreets warns the authority and asks to change e-mail or log in<br />- The activation code is not valid. The municipality user is asked to reinsert it<br />- The municipality user doesn't provide all the data. In this case the system asks to insert them<br /> |

| Name             | Login                                                        |
| ---------------- | ------------------------------------------------------------ |
| Actor            | Municipality user                                                |
| Entry conditions | - The municipality user has opened the application on his device<br />- The municipality user is already registered |
| Events flow      | - The municipality user chooses the *login* option<br />- The municipality user inserts his e-mail and password |
| Exit conditions  | The municipality user is identified                                  |
| Exceptions       | - The e-mail is not registered. The municipality user is asked to reinsert it or sign up<br />- The password is incorrect. The municipality user is asked to reinsert it |


| Name | Get intervention suggestion |
| -------  | --------- |
| Actor | Municipality user |
| Entry conditions | - The municipality user has opened the application on his device and logged in <br /> - The municipality user wants to get suggestions about possible improvements |
| Events flow | - The municipality user accesses the *SafeSuggestions* functionality <br /> - The municipality user selects the geographical filters <br /> - SafeStreets sends (if available) the suggestion relative to the filters provided <br />|
| Exit conditions | SafeStreets displays the suggestion (if given) or a "no suggestions" notice |
| Exceptions | / |

![](resources/get_intervention_suggestion_sequence_diagram.svg)

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

# 4.  FORMAL ANALYSIS USING ALLOY
<!--this section should include a brief presentation of the main objectives driving the formal modeling activity, as well as a description of the model itself, what can be proved with it, and why what is proved is important given the problem at hand. To show the soundness and correctness of the model, this section can show some worlds obtained by running it, and/or the results of the checks performed on meaningful assertions-->

# 5.  EFFORT SPENT
<!--in this section you will include information about the number of hours each group member has worked for this document-->

| Task                 | Braga | Calderon | Favaro |
| -------------------- | :---: | :------: | :----: |
| Introduction         |  10   |    5     |   5    |
| Product perspective  |       |          |        |
| Product functions    |       |          |        |
| User characteristics |       |          |        |
| Assumptions, dependencies and constraints |   5   |    5     |   5   |
| External Interface Requirements           |       |          |       |
| Functional Requirements                   |   5   |    5     |   9  |
| Assumptions, dependencies and constraints |   6   |    4     |   3   |
| External Interface Requirements           |       |          |       |
| Functional Requirements                   |   6   |    6     |  7  |
| Performance Requirements                  |       |          |       |
| Design Constraints                        |       |          |       |
| Software System Attributes                |       |          |       |
| Formal Analysis using Alloy               |       |          |       |

# 6.  REFERENCES
