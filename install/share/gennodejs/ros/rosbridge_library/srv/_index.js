
"use strict";

let AddTwoInts = require('./AddTwoInts.js')
let TestArrayRequest = require('./TestArrayRequest.js')
let TestResponseOnly = require('./TestResponseOnly.js')
let SendBytes = require('./SendBytes.js')
let TestNestedService = require('./TestNestedService.js')
let TestMultipleResponseFields = require('./TestMultipleResponseFields.js')
let TestRequestOnly = require('./TestRequestOnly.js')
let TestRequestAndResponse = require('./TestRequestAndResponse.js')
let TestMultipleRequestFields = require('./TestMultipleRequestFields.js')
let TestEmpty = require('./TestEmpty.js')

module.exports = {
  AddTwoInts: AddTwoInts,
  TestArrayRequest: TestArrayRequest,
  TestResponseOnly: TestResponseOnly,
  SendBytes: SendBytes,
  TestNestedService: TestNestedService,
  TestMultipleResponseFields: TestMultipleResponseFields,
  TestRequestOnly: TestRequestOnly,
  TestRequestAndResponse: TestRequestAndResponse,
  TestMultipleRequestFields: TestMultipleRequestFields,
  TestEmpty: TestEmpty,
};
