# Basic TestCafe API example with LambdaTest

*A set of sample tests that illustrate how to use TestCafe API with LambdaTest*

## Running the example

### Install testcafe

```sh
$ npm install -g testcafe
```

### Clone the repository

```sh
$ git clone https://github.com/LambdaTest/testcafe-sample.git
$ cd testcafe-sample
```

### Install dependencies

```sh
$ npm install
```

### Set environment variables

```sh
$ export LT_USERNAME=<Username>
$ export LT_ACCESS_KEY=<Access Key>
```
> The credentials can be copied from your [LambdaTest Profile](https://accounts.lambdatest.com/profile)

### Run single test
```sh
$ testcafe "lambdatest:Chrome@78.0:Windows 8" "test.js"
```

### Run parallel tests

- 2 parallel tests with single browser

```sh
$ testcafe -c 2 "lambdatest:Chrome@78.0:Windows 8" "test.js"
```

- 2 parallel tests with 2 browsers (4 tests concurrently)

```sh
$ testcafe -c 2 "lambdatest:Chrome@76.0:Windows 8","lambdatest:Chrome@78.0:Windows 10" "test.js"
```
Note:
The total parallel sessions should be less than or equals to the subscribed plan.

## About LambdaTest

[LambdaTest](https://www.lambdatest.com/) is a cloud based selenium grid infrastructure that can help you run automated cross browser compatibility tests on 2000+ different browser and operating system environments. All test data generated during testing including Selenium command logs, screenshots generated in testing, video logs, selenium logs, network logs, console logs, and metadata logs can be extracted using [LambdaTest automation APIs](https://www.lambdatest.com/support/docs/api-doc/). This data can then be used for creating custom reports.
