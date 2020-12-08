#  TestCafe Integration With LambdaTest

![TestCafe Integration With LambdaTest](https://cdn.lambdatest.com/support/docs/wp-content/uploads/2019/08/npm-testcafe-integration.jpg)

### Testcafe is a node.js tool to automate  end-to-end web testing .

Interesting part is that we don’t need an external driver to run end-to-end tests in the browser. Instead, the page can run all the test scripts that emulate user actions. This would allow for true cross-browser and cross-platform tests that run on any device that has a modern browser.

## Prerequisites for  Testcafe 

1. Download Visual Studio code (IDE)  for  writing code script : [https://code.visualstudio.com/download](https://code.visualstudio.com/download)

2.Node.js and Package Manager (npm) : Install Node.js from their [official website](https://nodejs.org/en/download/) Or Install 
**Node:** js using command line. Go to the terminal or command prompt & run the below command.

`$   install node`

 To verify the node version 
 
 `   $  node -v `

If node isn’t of the latest version then you can update it using the below command.

`$ npm install npm@latest -g`

3. Testcafe  Package Module : npm to install Testcafe

`$ npm init`

Install the testcafe using npm

`$ npm install -g testcafe`

4. Install LambdaTest npm plugin For TestCafe

`$ npm install testcafe-browser-provider-lambdatest`

Get  all available and supported configurations

`$ testcafe -b lambdatest`

5. LambdaTest Credentials

  * Set LambdaTest username and access key in environment variables. It can be obtained from LambdaTest dashboard
example:

For linux/mac :

`$export LT_USERNAME="YOUR_USERNAME"
 $export LT_ACCESS_KEY="YOUR ACCESS KEY"`
                   
                   
For Windows:

`$ set LT_USERNAME="YOUR_USERNAME"
 $ set LT_ACCESS_KEY="YOUR ACCESS KEY"`
                  
                  
6. Install Dependencies

`$ npm install`

## 5.IDE setup

 **Step 1 :** After installation, Create a Folder in your local system to save all the projects.
 
 **Step 2 :** Install some essential extensions for javascript from ‘Extensions’ in VScode Editor  like:  

  * Code Runner 
  * JavaScript( ES6) code snippet
  * ES Lint
 
**Step 3 :** press ‘control+shift+P’---search for git:clone

**Step 4 :**--paste the copied ( [https://github.com/LambdaTest/testcafe-sample.git](https://github.com/LambdaTest/testcafe-sample.git) ) repo -press ENTER and save testcafe project  in the above created folder.

**Step 5:** open testcafe project directory testcafe-sample  in VScode.

## Executing Testcafe Testing Script

We will create a project directory named **testcafe-sample** and then we will create two files  **page-model.js** and  **test.js** in it.

Finally, we will initialize our project by hitting the command **npm init**. This will create a **package.json** file in an interactive way, which will contain all our required project configurations. It will be required to execute our test script  **test.js**.

Here is the snapshot of **package.json**

 ```javascript
 {
  "name": "testcafe-sample",
  "version": "1.0.0",
  "description": "TestCafe API Sample",
  "main": "test.js",
  "scripts": {
    "test": "testcafe all test.js"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/LambdaTest/testcafe-sample.git"
  },
  "author": "",
  "license": "ISC",
  "bugs": {
    "url": "https://github.com/LambdaTest/testcafe-sample/issues"
  },
  "homepage": "https://github.com/LambdaTest/testcafe-sample#readme",
  "devDependencies": {
    "testcafe": "*"
  },
  "dependencies": {
    "testcafe-browser-provider-lambdatest": "^2.0.1"
  }
}

 ```

## Test Scenario 

In the Demonstration,we will be creating a script to launch a web application and perform various actions on the webpage like : 
‘Text typing basics','Click an array of labels and then check their states','Moving the slider',Dealing with text using keyboard','Dealing with text using selection''Handle native confirmation dialog', 'Pick option from select', 'Filling a form'
on the webpage ,and will be  using assertions to verify the test cases.  If assert returns true,  the test cases   pass successfully and show up in the automation logs dashboard, else if assert returns false, the test case fails, and the errors will be displayed in the automation log.

Single Test- On a single environment (Windows 10) and single browser (Chrome)

For this,
create one **page-model.js** file with a Selector function imported from the testcafe module which will  identify  webpage elements in the test and inspect elements stated on the page.

Let’s have a look on this file.

```
import { Selector } from 'testcafe';
 
const label = Selector('label');
 
class Feature {
    constructor (text) {
        this.label    = label.withText(text);
        this.checkbox = this.label.find('input[type=checkbox]');
    }
}
 
export default class Page {
    constructor () {
        this.nameInput             = Selector('#developer-name');
        this.triedTestCafeCheckbox = Selector('#tried-test-cafe');
        this.populateButton        = Selector('#populate');
        this.submitButton          = Selector('#submit-button');
        this.results               = Selector('.result-content');
        this.macOSRadioButton      = Selector('input[type=radio][value=MacOS]');
        this.commentsTextArea      = Selector('#comments');
 
        this.featureList = [
            new Feature('Support for testing on remote devices'),
            new Feature('Re-using existing JavaScript code for testing'),
            new Feature('Easy embedding into a Continuous integration system')
        ];
 
        this.slider = {
            handle: Selector('.ui-slider-handle'),
            tick:   Selector('.slider-value')
        };
 
        this.interfaceSelect       = Selector('#preferred-interface');
        this.interfaceSelectOption = this.interfaceSelect.find('option');
    }
}

```

Now, create one  **test.js** file to execute the test cases. For This, TestCafe must be organized in the form of Fixture(can also have more than one Fixture in the Testcafe test) , multiple test functions with test controller object  **‘t’** which exposes the test API's methods. Here is ,,**test.js** file that imports above page-model.js 
Let's have a look at **test.js** script.

```JavaScript
import Page from './page-model';
 
fixture `A set of examples that illustrate how to use TestCafe API`
    .page `https://devexpress.github.io/testcafe/example/`;
 
// Page model
const page = new Page();
 
// Tests
test('Text typing basics', async t => {
    await t
        .typeText(page.nameInput, 'Peter') // Type name
        .typeText(page.nameInput, 'Paker', { replace: true }) // Replace with last name
        .typeText(page.nameInput, 'r', { caretPos: 2 }) // Correct last name
        .expect(page.nameInput.value).eql('Parker'); // Check result
});
 
 
test('Click an array of labels and then check their states', async t => {
    for (const feature of page.featureList) {
        await t
            .click(feature.label)
            .expect(feature.checkbox.checked).ok();
    }
});
 
 
test('Dealing with text using keyboard', async t => {
    await t
        .typeText(page.nameInput, 'Peter Parker') // Type name
        .click(page.nameInput, { caretPos: 5 }) // Move caret position
        .pressKey('backspace') // Erase a character
        .expect(page.nameInput.value).eql('Pete Parker') // Check result
        .pressKey('home right . delete delete delete') // Pick even shorter form for name
        .expect(page.nameInput.value).eql('P. Parker'); // Check result
});
 
 
test('Moving the slider', async t => {
    const initialOffset = await page.slider.handle.offsetLeft;
 
    await t
        .click(page.triedTestCafeCheckbox)
        .dragToElement(page.slider.handle, page.slider.tick.withText('9'))
        .expect(page.slider.handle.offsetLeft).gt(initialOffset);
});
 
 
test('Dealing with text using selection', async t => {
    await t
        .typeText(page.nameInput, 'Test Cafe')
        .selectText(page.nameInput, 7, 1)
        .pressKey('delete')
        .expect(page.nameInput.value).eql('Tfe'); // Check result
});
 
 
test('Handle native confirmation dialog', async t => {
    await t
        .setNativeDialogHandler(() => true)
        .click(page.populateButton);
 
    const dialogHistory = await t.getNativeDialogHistory();
 
    await t.expect(dialogHistory[0].text).eql('Reset information before proceeding?');
 
    await t
        .click(page.submitButton)
        .expect(page.results.innerText).contains('Peter Parker');
});
 
 
test('Pick option from select', async t => {
    await t
        .click(page.interfaceSelect)
        .click(page.interfaceSelectOption.withText('Both'))
        .expect(page.interfaceSelect.value).eql('Both');
});
 
 
test('Filling a form', async t => {
    // Fill some basic fields
    await t
        .typeText(page.nameInput, 'Bruce Wayne')
        .click(page.macOSRadioButton)
        .click(page.triedTestCafeCheckbox);
 
    // Let's leave a comment...
    await t
        .typeText(page.commentsTextArea, "It's...")
        .wait(500)
        .typeText(page.commentsTextArea, '\ngood');
 
    // I guess, I've changed my mind
    await t
        .wait(500)
        .selectTextAreaContent(page.commentsTextArea, 1, 0)
        .pressKey('delete')
        .typeText(page.commentsTextArea, 'awesome!!!');
 
    // Let's submit our form
    await t
        .wait(500)
        .click(page.submitButton)
        .expect(page.results.innerText).contains('Bruce Wayne');
});
```

We are all set  with the script structure, and now need to run the **test.js** file from the terminal or command prompt  to initiate the test on the LambdaTest platform .

### Running the Test :

1. In the terminal,Go to the Directory location: cd testcafe-sample

2. Set your Username and Accesskey 

Here is the snapshot for above steps:

```
C:\Users\Admin\Desktop\vscode\testcafe-sample> set LT_USERNAME= shwetas

C:\Users\Admin\Desktop\vscode\testcafe-sample>set LT_ACCESS_KEY= 5657878ghyg
```

Now it’s time to enter the command for executing the test on desired configuration

```
C:\Users\Admin\Desktop\vscode\testcafe-sample>testcafe "lambdatest:Chrome @85.0:Windows 10" "test.js"
```
Tunnel established connection internally after authentication of credentials:

![](https://www.lambdatest.com/blog/wp-content/uploads/2020/04/test2.png)

Assertions passed and the test succeeded.

![](https://www.lambdatest.com/blog/wp-content/uploads/2020/04/test3.png)

## Parallel Testing for Testcafe JavaScript

`For 2 parallel tests with same configurations`

For running 2 parallel on same configuration-: add flag  -c 2
 Here c 2( concurrency 2) signifies you are  running 2 parallel tests on same configuration

```
C:\Users\Admin\Desktop\vscode\testcafe-sample>testcafe -c 2 "lambdatest:Chrome@85.0:Windows 10" "test.js"
```

Similarly you can  run  N   number of tests in parallel tests on same configuration( N depends upon the plan subscription)

**Note:** The total parallel sessions should be less than or equals to the subscribed plan.

 For  parallel tests on different configurations:
 
 ```
 C:\Users\Admin\Desktop\vscode\testcafe-sample>testcafe  "lambdatest:Chrome@85.0:Windows 10","lambdatest:Firefox@84.0:Windows 8.1","lambdatest:Chrome@85.0:macOS Mojave" "test.js"
```

Tunnel established connection internally after authentication of credentials:

![](https://www.lambdatest.com/blog/wp-content/uploads/2020/04/test7.png)

All the parallel tests initiated simultaneously on the Lambdatest platform in Running state.
Here is the snapshot

![](https://www.lambdatest.com/blog/wp-content/uploads/2020/04/test8.png)

After completion of all test cases in  all the parallel tests , assertions passed and test executed successfully on .With the video provided for each test , test cases would be verified.

**Additional Configuration Parameters:**

Set values to below variables if required ,

Values | 
------------ | 
 LT_TEST_NAME | 
LT_BUILD | 
LT_CAPABILITY_PATH |
LT_RESOLUTION |
LT_LOGFILE |
LT_VERBOSE |
LT_PROXY_HOST |
LT_PROXY_PORT |
LT_PROXY_USER |
LT_DIR |
LT_SELENIUM_VERSION |


Assign flag as true or false to below variables if required:

variables | 
------------ | 
 LT_CONSOLE | 
LT_NETWORK | 
LT_VIDEO |
LT_SCREENSHOT |
LT_TIMEZONE |


## About LambdaTest

[LambdaTest](https://www.lambdatest.com/) is a cloud based selenium grid infrastructure that can help you run automated cross browser compatibility tests on 2000+ different browser and operating system environments. LambdaTest supports all programming languages and frameworks that are supported with Selenium, and have easy integrations with all popular CI/CD platforms. It's a perfect solution to bring your [selenium automation testing](https://www.lambdatest.com/selenium-automation) to cloud based infrastructure that not only helps you increase your test coverage over multiple desktop and mobile browsers, but also allows you to cut down your test execution time by running tests on parallel.
