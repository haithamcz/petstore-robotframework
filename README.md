# petstore-robotframework-test
Api and Web selenium tests to test pet store application to ensure DoD
- The website is responsive and all features work on small screens (> 400px width)
- run on supported browser is Chrome (latest version)

### Test pre requisites 
    -   python installed version Python 2.7.10
    -   PIP installed https://pip.pypa.io/en/stable/installing/
    -   robotframework installation instruciton https://github.com/robotframework/robotframework/blob/master/INSTALL.rst
        -- required robotframework library
            robotframework-selenium2library==1.8.0
            robotframework-requests==0.4.7
            requests==2.18.1
    -   Chrome installed latest
    -   Chrome driver http://chromedriver.chromium.org/downloads and added to system environment path
    
     

## API tests
CRUD tests to cover pet store api/pets https://github.com/ace-study-group/assignment-qa/blob/master/assignment/USER-STORIES.md

## Web tests
Collection of tests to cover UI user stories DoD defined https://github.com/ace-study-group/assignment-qa/blob/master/assignment/USER-STORIES.md


####  Test design
The tests are designed to run independent from each other.
Tests are the start will clear out the environment from any previous test data to ensure test consistency, <b>please be careful running them against your internal environment.</b>
### Running the tests
To run the tests in terminal navigate to api or web test cases folder for example api tests (petstore/testcases/api)  and type: <pre><code>robot api_tests.robot </code></pre>
The test will run and generate test report in petstore/testcases/api (you can generate test report to different directory by adding --d to the run command)
The tests should be able to ingest test data and clean up the DB after they execute
For API test all tests should pass however UI tests some of the tests would fail
and that will require further actions and team discussion.

The Web test were executed on full resolution and on against 400 resolution.
The windows resolution could be override by changing default width/height parameter in test configuration  

### Test Structure and naming
Test case naming, I used similar names to the corresponding US name to keep close mapping between tests and user stories acceptance criteria 

Test structure:-

        -- /resources test config, data, web page methods, locators, common methods
        --/reports
        
## Test Notes
Some of the acceptance criteria where not possible to automate, like the <b>location of current date</b> in US01.

 
