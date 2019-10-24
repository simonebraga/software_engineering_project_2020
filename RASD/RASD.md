[TOC]

# INTRODUCTION

## Purpose
<!--here we include the goals of the project-->

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

### Acronyms

* **MTS (Municipality Tickets Service)** Service offered by the municipality to generate traffic tickets from information about the violations.
* **OCR (Optical Character Recognition)** Software that converts text scanned from a photo in a machine-encoded text

### Abbreviations

## Revision history
## Reference Documents
## Document Structure

**Section 1** is an overall introduction to the application. It includes the description of the main functionalities of the application, an analysis of scenarios in which the application works, the list of the potential users of the application with a concise description of the possible interactions and the definition of world-level goals. Also, some meta-informations are included, like revision history, references, and explanation of the conventions occurring in the document.

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

| Task                                      | Braga | Calderon | Favaro |
| ----------------------------------------- | :---: | :------: | :----: |
| Introduction                              |   6   |    3     |   3    |
| Product perspective                       |       |          |        |
| Product functions                         |       |          |        |
| User characteristics                      |       |          |        |
| Assumptions, dependencies and constraints |   5   |    3     |   3    |
| External Interface Requirements           |       |          |        |
| Functional Requirements                   |   5   |    3     |   3    |
| Performance Requirements                  |       |          |        |
| Design Constraints                        |       |          |        |
| Software System Attributes                |       |          |        |
| Formal Analysis using Alloy               |       |          |        |

# REFERENCES