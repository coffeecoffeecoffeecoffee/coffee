import React from "react";
import { connect } from "react-redux";
import EventsList from "../components/EventsList";
import { eventsFetchStart } from "../actionCreators";

class EventsListContainer extends React.Component {
  componentDidMount() {
    const {
      eventsFetchStart,
      match: {
        params: { groupID }
      }
    } = this.props;
    eventsFetchStart(groupID);
  }

  render() {
    const { events } = this.props;
    return <EventsList events={events} />;
  }
}

const mapStateToProps = ({ events }) => ({
  events
});

const mapDispatchToProps = {
  eventsFetchStart
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(EventsListContainer);
