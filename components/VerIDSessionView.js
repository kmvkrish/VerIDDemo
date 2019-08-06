import PropTypes from 'prop-types';
import React from 'react';
import {requireNativeComponent} from 'react-native';

class VerIDSessionView extends React.Component {

    _onSessionFinished = (event) => {
        if (!this.props.onSessionFinished) {
            return;
        }
        this.props.onSessionFinished(event.nativeEvent);
    }

    _onSessionCanceled = (event) => {
        if (!this.props.onSessionCanceled) {
            return;
        }
        this.props.onSessionCanceled(event.nativeEvent);
    }

    render() {
        return <RCTSessionView style={{flex:1}} {...this.props} sessionStarted={false} onSessionFinished={this._onSessionFinished} onSessionCanceled={this._onSessionCanceled} />;
    }
}

VerIDSessionView.propTypes = {
    onSessionFinished: PropTypes.func,
    onSessionCanceled: PropTypes.func
};

var RCTSessionView = requireNativeComponent('RCTSessionView', VerIDSessionView);

module.exports = VerIDSessionView;