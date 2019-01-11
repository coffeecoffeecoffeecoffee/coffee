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
