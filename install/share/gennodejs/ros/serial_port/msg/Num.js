// Auto-generated. Do not edit!

// (in-package serial_port.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Num {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.leftspeed = null;
      this.rightspeed = null;
    }
    else {
      if (initObj.hasOwnProperty('leftspeed')) {
        this.leftspeed = initObj.leftspeed
      }
      else {
        this.leftspeed = 0.0;
      }
      if (initObj.hasOwnProperty('rightspeed')) {
        this.rightspeed = initObj.rightspeed
      }
      else {
        this.rightspeed = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Num
    // Serialize message field [leftspeed]
    bufferOffset = _serializer.float32(obj.leftspeed, buffer, bufferOffset);
    // Serialize message field [rightspeed]
    bufferOffset = _serializer.float32(obj.rightspeed, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Num
    let len;
    let data = new Num(null);
    // Deserialize message field [leftspeed]
    data.leftspeed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rightspeed]
    data.rightspeed = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'serial_port/Num';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8b290d1f063538827f22923db0bccdbf';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 leftspeed  
    float32 rightspeed
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Num(null);
    if (msg.leftspeed !== undefined) {
      resolved.leftspeed = msg.leftspeed;
    }
    else {
      resolved.leftspeed = 0.0
    }

    if (msg.rightspeed !== undefined) {
      resolved.rightspeed = msg.rightspeed;
    }
    else {
      resolved.rightspeed = 0.0
    }

    return resolved;
    }
};

module.exports = Num;
