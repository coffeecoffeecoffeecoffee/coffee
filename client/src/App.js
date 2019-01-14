import React from "react";
import { Provider } from "react-redux";
import { BrowserRouter as Router, Route } from "react-router-dom";
import store from "./store";
import GroupsListContainer from "./containers/GroupsListContainer";
import Header from "./components/Header";
import Page from "./components/Page";
import Footer from "./components/Footer";

const App = () => (
  <Provider store={store}>
    <Router>
      <Page>
        <Header />
        <Route path="/" exact component={GroupsListContainer} />
        <Route path="/groups" component={GroupsListContainer} />
        <Footer />
      </Page>
    </Router>
  </Provider>
);

export default App;
