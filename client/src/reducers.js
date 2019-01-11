import { createReducer } from "redux-starter-kit";
import { groupsFetchSuccess } from "./actionCreators";

const initialState = {
  groups: []
};

const rootReducer = createReducer(initialState, {
  [groupsFetchSuccess]: (state, action) => ({
    ...state,
    groups: action.payload
  })
});

export default rootReducer;
