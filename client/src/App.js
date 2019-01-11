import React from "react";
import { Provider } from "react-redux";
import store from "./store";
import GroupsListContainer from "./containers/GroupsListContainer";
import Header from "./components/Header";
import Page from "./components/Page";
import Footer from "./components/Footer";

const App = () => (
  <Provider store={store}>
    <Page>
      <Header />
      <GroupsListContainer />
      <Footer />
    </Page>
  </Provider>
);

export default App;
