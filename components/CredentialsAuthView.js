import React, { Component } from 'react';

import {
    View,
    StyleSheet,
    Button,
    Text,
    TextInput,
    Keyboard
} from 'react-native';
import { thisExpression } from '@babel/types';

export default class CredentialsAuthView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            username: "",
            password: ""
        };
    }

    onChangeUsername = (username) => {
        console.log(username);
        this.setState({
            username: username
        });
    }

    onChangePassword = (password) => {
        this.setState({
            password: password
        });
    }

    onBlur() {
        Keyboard.dismiss();
    }

    render() {
        return (
            <View style={styles.containerStyle}>
                <View style={styles.headingContainer}>
                    <Text style={styles.loginTextStyle}>Login with credentials</Text>
                </View>
                <View style={styles.loginContainerStyle}>
                    <View style={styles.formGroupStyle}>
                        <Text style={styles.formLabelStyle}>Username:</Text>
                        <View style={styles.textInputViewStyle}>
                            <TextInput value={this.state.username} onBlur={this.onBlur} onChange={this.onChangeUsername} style={styles.textInputStyle} />
                        </View>
                    </View>
                    <View style={styles.formGroupStyle}>
                        <Text style={styles.formLabelStyle}>Password:</Text>
                        <View style={styles.textInputViewStyle}>
                            <TextInput value={this.state.password} onBlur={this.onBlur} secureTextEntry={true} onChange={this.onChangePassword} style={styles.textInputStyle} />
                        </View>
                    </View>
                    <View style={styles.loginButtonStyle}>
                        <Button title="Sign In" />
                    </View>
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    containerStyle: {
        flex: 7,
        backgroundColor: '#339BFC'
    },
    headingContainer: {
        flex: 3,
        padding: 2,
        alignItems: 'center',
        justifyContent: 'center'
    },
    loginContainerStyle: {
        flex: 7,
        flexDirection: 'column',
        justifyContent: 'flex-start',
        alignContent: 'flex-start',
        alignSelf: 'center',
        width: '80%',
        margin: 0
    },
    loginTextStyle: {
        color: 'white',
        fontSize: 18,
        fontWeight: 'bold',
        fontFamily: 'Courier New'
    },
    formGroupStyle: {
        paddingLeft: 5,
        paddingRight: 5,
        marginBottom: 10
    },
    formLabelStyle: {
        fontSize: 12,
        color: 'white',
        fontWeight: 'bold',
        marginBottom: 5
    },
    textInputViewStyle: {
        backgroundColor: 'white',
        borderWidth: 1,
        borderColor: 'black',
        padding: 5,
        borderRadius: 5
    },
    textInputStyle: {
        height: 25,
        color: '#339BFC'
    },
    loginButtonStyle: {
        width: '25%',
        alignSelf: 'center',
        backgroundColor: 'white',
        color: '#33FC98',
        borderWidth: 0.5,
        borderColor: 'black',
        borderRadius: 40,
    }
});