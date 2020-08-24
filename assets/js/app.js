import '../css/app.scss'

import 'phoenix_html'
import { Socket } from 'phoenix'
import $ from 'jquery'

class Chat {
    constructor() {
        this.socket = new Socket("/socket")
        this.channel = this.socket.channel("room:lobby", {})
        this.nameInput = $('input#name')
        this.messageInput = $('input#message')
        this.messageList = $('#message-list')
    }

    name() {
        const value = this.nameInput.val()
        return value !== '' ? value : 'Guest'
    }

    message() { return this.messageInput.val() }

    setup() {
        this.socket.connect()
        this.channel.join().receive('ok', () => { console.log('Joined to chat') })
        this.channel.on("broadcast", data => {
            this.printMessage(data['name'], data['message'])
        })
    }

    sendMessage() {
        this.channel.push("broadcast", { name: this.name(), message: this.message() })
        this.messageInput.val('')
    }

    printMessage(name, message) {
        this.messageList.append(`<li><b>${name}:</b> ${message}</li>`)
        this.messageList[0].scrollTop = this.messageList[0].scrollHeight;
    }
}

$(document).ready(() => {
    const chat = new Chat()
    chat.setup();

    chat.messageInput.keypress((event) => {
        const enterKeycode = 13
        const keycode = (event.keyCode ? event.keyCode : event.which)
        if (keycode === enterKeycode && chat.message() !== '') { chat.sendMessage() }
    })
}) 