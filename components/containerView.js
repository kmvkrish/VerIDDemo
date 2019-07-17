import React, { Component } from 'react';

import {
    View,
    StyleSheet,
    requireNativeComponent
} from 'react-native';

export default class ContainerView extends Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <View style={StyleSheet.containerStyle}>
                <RCTContainerView style={{flex: 1}} {...this.props} />
            </View>
        );
    }

}

const RCTContainerView = requireNativeComponent('RCTContainerView', ContainerView);
module.exports = RCTContainerView;