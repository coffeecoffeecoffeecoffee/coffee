import { createReducer } from "redux-starter-kit";
import { eventsFetchSuccess, groupsFetchSuccess } from "./actionCreators";

// TODO: Reconstruct state around normalized data.
// https://redux.js.org/recipes/structuring-reducers/normalizing-state-shape
// https://github.com/paularmstrong/normalizr
const initialState = {
  groups: [],
  events: []
};

const rootReducer = createReducer(initialState, {
  [eventsFetchSuccess]: (state, action) => ({
    ...state,
    events: action.payload
  }),
  [groupsFetchSuccess]: (state, action) => ({
    ...state,
    groups: action.payload
  })
});

export default rootReducer;
