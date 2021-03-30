# CreditScoreAnalyser UI Application

A Sample UI application, which shows user's credit score by reading data from json.

### Case study:

* Developer should create the sample UI application with all necessary features.
* Re-usable components should be designed for better code modularisation.
* Unit-test cases should be written for bussiness logic.

Note: Developer is free to use any image assets from the internet. (only if necessary)

### Sample UI:
![alt_text](https://github.com/vinayhosamane/CreditScoreAnalyser/blob/main/Documentation%20Resources/Screenshot%202021-03-27%20at%204.22.59%20PM.png)

### Development Approach:

* Developed re-usable circle custom view.
* Developed re-usable scale custom view.
* Developed re-usable scale marker custom view.
* Developed re-usable search view.
* Moved all these custom views to framework.
* Embedded custom views framework into app project and developed dashboard.

### Code Coverage:

I have written unit test cases for the bussiness logic, where basically calculating credit score and it's scale are implmented.
It is about 83% code coverage for the file CreditScoreCalculator.swift

Note: We can use XCUITests to test custom views to match the requirement.

### Final Outcome:

![alt_text](https://github.com/vinayhosamane/CreditScoreAnalyser/blob/main/Documentation%20Resources/Screenshot%202021-03-28%20at%2012.50.17%20PM.png)

### Improvements

* UI can be developed with size class in considerations. i.e supoprting auto layout in multiple device formats. This needs some sort of UI layout design from UX team.
* XCUITest cases can be implmented to make sure there are no regressions on UI requirements in future.
