import axios from "axios";
import { createAction } from "redux-starter-kit";

// Very similar to redux-starter-kit's createAction (see link) but with a thunk
// https://github.com/reduxjs/redux-starter-kit/blob/master/src/createAction.js
function createAsyncAction(type, thunk) {
  const action = payload => thunk(payload);
  action.toString = () => type;
  return action;
}

// Action naming convention:
// https://github.com/Versent/redux-crud/blob/master/docs/actions.md

export const eventsFetchSuccess = createAction("EVENTS_FETCH_SUCCESS");
export const eventsFetchError = createAction("EVENTS_FETCH_ERROR");
export const eventsFetchStart = createAsyncAction(
  "EVENTS_FETCH_START",
  groupID => dispatch =>
    axios
      .get(`/api/groups/${groupID}/events`)
      .then(response => {
        dispatch(eventsFetchSuccess(response.data));
      })
      .catch(error => {
        dispatch(eventsFetchError(error));
      })
);

export const groupsFetchSuccess = createAction("GROUPS_FETCH_SUCCESS");
export const groupsFetchError = createAction("GROUPS_FETCH_ERROR");
export const groupsFetchStart = createAsyncAction(
  "GROUPS_FETCH_START",
  () => dispatch =>
    axios
      .get("/api/groups")
      .then(response => {
        dispatch(groupsFetchSuccess(response.data));
      })
      .catch(error => {
        dispatch(groupsFetchError(error));
      })
);
