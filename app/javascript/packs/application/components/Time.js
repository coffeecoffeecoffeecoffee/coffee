import React from "react";
import moment from "moment";

const formatTime = time => moment(time).format("dddd, MMMM Do YYYY, h:mm a");

const Time = ({ time, ...rest }) => <time {...rest}>{formatTime(time)}</time>;

export default Time;
