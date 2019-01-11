import React from "react";
import { connect } from "react-redux";
import GroupsList from "../components/GroupsList";
import { groupsFetchStart } from "../actionCreators";

class GroupsListContainer extends React.Component {
  componentDidMount() {
    const { groupsFetchStart } = this.props;
    groupsFetchStart();
  }

  render() {
    const { groups } = this.props;
    return <GroupsList groups={groups} />;
  }
}

const mapStateToProps = ({ groups }) => ({
  groups
});

const mapDispatchToProps = {
  groupsFetchStart
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(GroupsListContainer);
