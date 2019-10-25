[TOC]

# INTRODUCTION

## Purpose
<!--here we include the goals of the project-->

**SafeStreets** is a crowd-sourced application that intends to provide users with the possibility to notify authorities when traffic violations occur. The main target of the application are violations that can be easily captured by a camera (like, for instance, parking violations).

The core of the application is **SafeReports**, which is the service that provides to the users the possibility to send a notification. To do so, they are requested to take a picture of the vehicle involved in the violation. Then the photo is checked and matched with some data captured at the moment (position, date and time) and sent to SafeStreets, which stores it to offer several services based on the analysis of these data.

The first one is **SafeAnalytics**, which provides the possibility to mine SafeStreets data to get information about violations. This service is offered to users and authorities, that can access data with different restriction levels. Users have access to anonymous and aggregate data concerning a selected zone. Authorities, instead, have access to unrestricted information on all the stored data.

SafeStreets must forward violation reports to Municipality Tickets Service to automatically generate traffic tickets. Data about issued tickets must be stored and analyzed to provide statistics to the authorities through **SafeTickets**, which is another service thought to be enjoyed by authorities.

The last service provided by SafeStreets is thought for the municipality. Its name is **SafeSuggestions**, and its purpose is to analyze the data collected by SafeStreets to suggest possible interventions aimed at reducing the incidence of accidents and violations in the most critical zones.

The purpose of the software is captured by the following goals:

* **G1**	SafeStreets must allow users to send pictures of violations, including their date, time and position.

* **G2**	Users must be allowed to access to anonymous and aggregated data.
* **G3**	Authorities must be allowed to access to all the data without restrictions.
* **G4**	SafeStreets must suggest possible interventions according to data about violations and accidents.
* **G5**	SafeStreets must be able to generate traffic tickets using MTS.
* **G6**	Data provided to generate traffic tickets must be checked to guarantee their reliability.
* **G7**	SafeStreets must provide statistics on issued tickets.

## Scope
<!--here we include an analysis of the world and of the shared phenomena-->

## Definitions, Acronyms, Abbreviations

### Definitions

* **User** [TOBEDEFINED]

* **Authority** [TOBEDEFINED]
* **Municipality** [TOBEDEFINED]
* **Timestamp** [TOBEDEFINED]
* **Violation report** [TOBEDEFINED]
* **Equivalent events** [TOBEDEFINED]
* **Activation code** [TOBEDEFINED]

### Acronyms

* **MTS (Municipality Tickets Service)** Service offered by the municipality to generate traffic tickets from information about the violations.

* **OCR (Optical Character Recognition)** Software that converts text scanned from a photo in a machine-encoded text

### Abbreviations

## Revision history
## Reference Documents
## Document Structure

**Section 1** is an overall introduction to the application. It includes the description of the main functionalities of the application, an analysis of scenarios in which the application works, the list of the potential users of the application with a concise description of the possible interactions and the definition of world-level goals. Also, some meta-data are included, like revision history, references, and explanation of the conventions occurring in the document.

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
* **D13**	Authorities are previously verified.
* **D14**	MTS provides an uninterrupted service.
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

**G1)	SafeStreets must allow users to send pictures of violations, including their date, time and position.**

* **R1**	When a picture is taken using [VIOLATIONREPORTFUNCTIONALITY], a new violation record is generated.

* **R2**	When a new violation record is generated, the current position of the user is automatically detected and added to the report.
* **R3**	When a new violation record is generated, the timestamp is added to the report.
* **R4**	When a new violation record is generated, the photo is scanned by an OCR software to automatically detect the plate.
* **R5**	If the OCR software fails in detecting the plate, the user is notified about it and asked to repeat the procedure.
* **R6**	If the OCR software detects the plate, the user is asked to confirm the violation report.
* **R7**	If the user confirms the violation report, it is sent to SafeStreets.
* **R8**	SafeStreets stores the information about the violation only if there are no equivalent events already stored.

**G2)	Users must be allowed to access to anonymous and aggregated data.**

* **R9**	[REQUESTFUNCTIONALITY] allows users to get information about violations in a specific zone and time interval.

* **R10**	[REQUESTFUNCTIONALITY] anonymizes information before sending it to the user.

**G3)	Authorities must be allowed to access to all the data without restrictions.**

* **R11**	[SPECIALREQUESTFUNCTIONALITY] allows authorities to get unrestricted information about violations.

**G4)	SafeStreets must suggest possible interventions according to data about violations and accidents.**

* **R12**	SafeStreets must store data about accidents provided by the municipality when available.

* **R13**	SafeStreets must analyze collected data crossed with data from the municipality to suggest possible interventions.

**G5)	SafeStreets must be able to generate traffic tickets using MTS.**

* **R14**	SafeStreets must forward every new stored violation report to MTS in order to generate traffic tickets.

**G6)	Data provided to generate traffic tickets must be checked to guarantee their reliability.**

* **R15**	When the users send a violation report, its integrity is checked.

* **R16**	If the integrity check is successful, the violation report is stored. Otherwise, the violation report is discarded.

**G7)	SafeStreets must provide statistics on issued tickets.**

* **R17**	When a new ticket is generated using MTS, ticket-related information is stored by SafeStreets.

* **R18**	SafeStreets must build statistics from stored data about issued tickets.
* **R19**	[SPECIALREQUESTFUNCTIONALITY] allows authorities to get information and statistics on issued tickets.

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
| Introduction         |  10   |    3     |   5    |
| Product perspective  |       |          |        |
| Product functions    |       |          |        |
| User characteristics |       |          |        |
| Assumptions, dependencies and constraints |   5   |    3     |   5   |
| External Interface Requirements           |       |          |       |
| Functional Requirements                   |   5   |    3     |   5  |
| Assumptions, dependencies and constraints |   6   |    3     |   3   |
| External Interface Requirements           |       |          |       |
| Functional Requirements                   |   6   |    3     |  7  |
| Performance Requirements                  |       |          |       |
| Design Constraints                        |       |          |       |
| Software System Attributes                |       |          |       |
| Formal Analysis using Alloy               |       |          |       |

# REFERENCES
