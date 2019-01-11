import React from "react";
import { Provider } from "react-redux";
import store from "./store";
import GroupsListContainer from "./containers/GroupsListContainer";

const App = () => (
  <Provider store={store}>
    <GroupsListContainer />
  </Provider>
);

export default App;
