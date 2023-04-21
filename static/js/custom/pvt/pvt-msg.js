//
$(".msg-paths .control .my-people-btn").click(function() {
    $(".msg-paths .control").css("display", "none");
    $(".msg-paths .search-my-people-con").css("display", "flex");
    $(".incoming-messages").css("display", "none");
    $(".my-people-section").css("display", "block");
})
$(".msg-paths .my-people-cancel").click(function() {
    $(".msg-paths .control").css("display", "flex");
    $(".msg-paths .search-my-people-con").css("display", "none");
    $(".incoming-messages").css("display", "block");
    $(".my-people-section").css("display", "none");
})

/**
 *  mobile code
 */
/**
 *  let's reload if there is a resize event
 */


if (innerWidth < 800) {
    // show conversation when a message is clicked
    let messages = document.querySelectorAll(".messages .msg");

    messages.forEach(msg => {
        msg.addEventListener("click", function(e) {
            // hide messages container
            document.querySelector(".msg-sub-page").style.display = "none";

            //fetch coversations specific to this user and message sender
            // display conversation box
            document.querySelector(".chat-section").style.display = "block";

        });
    });
    // show corresponding conversation on any person icon click
    let people = document.querySelectorAll(".people-section .person");
    people.forEach(person => {
        person.addEventListener("click", function(e) {
            // hide messages container
            document.querySelector(".people-section").style.display = "none";
            document.querySelector(".msg-sub-page").style.display = "none";

            //fetch coversations specific to this user and message sender
            // display conversation box
            document.querySelector(".chat-section").style.display = "block";

        });
    });
    // conversation-back-btn
    $(".conversation-back-btn").click(function(e) {
        $(".people-section").css("display", "none");
        $(".chat-section").css("display", "none");
        $(".msg-sub-page").fadeIn("fast");
        $(".people-controller").css("display", "block");
    });
    // people section controller
    $(".people-controller").click(function(e) {

        $(".people-section").fadeIn();
        $(".chat-section").css("display", "none");
        $(".msg-sub-page").css("display", "none");
    });
    // network-back-btn
    $(".network-back-btn").click(function(e) {
        $(".people-section").css("display", "none");

        $(".chat-section").css("display", "none");
        $(".msg-sub-page").fadeIn("fast");
        $(".people-controller").fadeIn("fast");
    });
}

function getWidth() {
    return window.innerWidth;
}

// hide conversation sub page
$(".chat-pane .cancel").click(function() {
    if (getWidth()) {
        $(".chat-board").css("display", "none");
        $(".incoming-messages-section").css("display", "block");
    } else {
        // do nothing...i guess.
    }
});

/**
 *  code to continously fetch latest, unread messages of this logged in user
 *  first, get the container for the incoming messsages
 *  keep updating all msg's
 */
let incomingMessagesCon = document.querySelector(".incoming-messages");
$.post("/message/inbox", {}, function(data, status) {
    //alert(data);
    let incomingMessages = JSON.parse(data);

    let unique = [];
    let distinct = [];
    for (let index = 0; index < incomingMessages.length; index++) {

        if (!unique[incomingMessages[index].sender.id]) {
            distinct.push(incomingMessages[index]);
            unique[incomingMessages[index].sender.id] = 1;
        }
    }
    // console.log(distinct);
    distinct.forEach(dMsg => {
        msgMaker(dMsg);
    });
    let lastMessageDate = distinct[0].datetime;
    /** 
     *  to fetch more incomming messages, remove duplicates and appending them
     */

    setInterval(() => {
        $.post("/message/inbox/latest", {
            "LMT": lastMessageDate
        }, function(data, status) {
            //alert(data);
            let incomingMessages2 = JSON.parse(data);

            if (incomingMessages2.length > 0) {
                let unique2 = [];
                let distinct2 = [];
                for (let index2 = 0; index2 < incomingMessages2.length; index2++) {

                    if (!unique2[incomingMessages2[index2].sender.id]) {
                        distinct2.push(incomingMessages2[index2]);
                        unique2[incomingMessages2[index2].sender.id] = 1;
                    }

                }
                let shownMessages = document.querySelectorAll(".incoming-msg");
                distinct2.forEach(dMsg2 => {
                    shownMessages.forEach(shownMsg => {
                        if (shownMsg.dataset.senderId == dMsg2.sender.id) {
                            shownMsg.remove();

                        }
                    });
                    prependMsgMaker(dMsg2);
                    // update shown messages count
                    shownMessages = document.querySelectorAll(".incoming-msg");
                    shownMessages = new Set(shownMessages);
                });
                //update last message date
                lastMessageDate = distinct2[0].datetime;
            } else {
                console.log("empty response")
            }


        })
    }, 100);







    function msgMaker(msg) {
        //console.log(msg)
        let newMsg = document.createElement("article");
        newMsg.setAttribute("class", "incoming-msg");
        newMsg.setAttribute("data-msg-id", msg.id);
        newMsg.setAttribute("data-sender-id", msg.sender.id);
        // add event handler on the new msg
        newMsg.addEventListener("click", function() {
            // pass sender ID to message sending button when clicked
            document.querySelector(".msg-send-form").dataset.to = msg.sender.id;


            // display chat area if need be
            if (getWidth() < 992) {
                // it means it's not a desktop screen...
                $("default-text").css("display", "none");
                $(".chat-board").css("display", "block");
                $(".incoming-messages-section").css("display", "none");
            } else {
                // desktop mode
                $(".default-text").css("display", "none");
                $(".chat-board").css("display", "block");
            }
            /**
             *  code to continuously fetch conversation
             */



        });
        // add sender image
        let senderImage = document.createElement("img");
        senderImage.setAttribute("class", "sender-photo ");
        senderImage.src = "/storage/profile/" + msg.sender.photo;
        newMsg.appendChild(senderImage);
        // add footer
        let msgFoot = document.createElement("footer");
        msgFoot.setAttribute("class", "details");
        newMsg.appendChild(msgFoot);
        // add username and date container to msg foot
        let uAd = document.createElement("p");
        uAd.setAttribute("class", "uad");
        uAd.innerHTML = `<b class="username ">${msg.sender.username}</b><span class="date ">${msg.datetime}</span>`;
        msgFoot.appendChild(uAd);
        // add msg content to foot
        let msgBody = document.createElement("p");
        msgBody.setAttribute("class", "body");
        msgBody.textContent = msg.body;
        msgFoot.appendChild(msgBody);


        // finally, add the message card to the messages container
        incomingMessagesCon.appendChild(newMsg);

    }


})

// messaging send functionality
let sendForm = document.querySelector(".msg-send-form");
sendForm.addEventListener("submit", function(e) {
    let bodyInput = document.querySelector("#body");
    e.preventDefault();
    let postData = {
        "to": e.target.dataset.to,
        "body": bodyInput.value
    }
    $.post("/message/send", postData, function(data, status) {
        //alert(data);
        if (data == 1) {
            bodyInput.value = "";
        }
    });
})





















function prependMsgMaker(msg) {
    let newMsg = document.createElement("article");
    newMsg.setAttribute("class", "incoming-msg");
    newMsg.setAttribute("data-msg-id", msg.id);
    // add event handler on the new msg
    newMsg.addEventListener("click", function() {
        // pass sender ID to message sending button when clicked
        document.querySelector(".msg-send-form").dataset.to = msg.sender.id;


        // display chat area if need be
        if (getWidth() < 992) {
            // it means it's not a desktop screen...
            $("default-text").css("display", "none");
            $(".chat-board").css("display", "block");
            $(".incoming-messages-section").css("display", "none");
        } else {
            // desktop mode
            $(".default-text").css("display", "none");
            $(".chat-board").css("display", "block");
        }
    });
    // add sender image
    let senderImage = document.createElement("img");
    senderImage.setAttribute("class", "sender-photo");
    senderImage.src = "/storage/profile/" + msg.sender.photo;
    newMsg.appendChild(senderImage);
    // add footer
    let msgFoot = document.createElement("footer");
    msgFoot.setAttribute("class", "details");
    newMsg.appendChild(msgFoot);
    // add username and date container to msg foot
    let uAd = document.createElement("p");
    uAd.setAttribute("class", "uad");
    uAd.innerHTML = `<b class="username ">${msg.sender.username}</b><span class="date ">${msg.datetime}</span>`;
    msgFoot.appendChild(uAd);
    // add msg content to foot
    let msgBody = document.createElement("p");
    msgBody.setAttribute("class", "body");
    msgBody.textContent = msg.body;
    msgFoot.appendChild(msgBody);
    // finally, add the message card to the messages container
    incomingMessagesCon.prepend(newMsg);

}





















// var Reciever = -1
// var Sender = -1
// var chatState = 0
// var canceld = true
// var POS = 0

// // the function below constantly checks the database for chats 
// function constantChecking() {
//     if (POS == 0)
//         $.post("/message/checkchat", { receiver: Reciever, state: chatState }, function(data) {
//             POS == 0 ? $("#newer").css("display", "none") : $("#newer").css("display", "block")
//             if (data === "zeroState") {
//                 if (canceld) constantChecking()
//             } else {
//                 let messages = JSON.parse(data)
//                 chatState = messages[1]
//                 console.log(messages)
//                 messages[0].map(message => {
//                     if (Number(message.sender) === Number(Sender)) {
//                         let sender = $("#sender").clone().attr("id", "senderq")
//                         sender.children().first().text(message.body)
//                         $(".conversations").append(sender)
//                     } else if (Number(message.sender) === Number(Reciever)) {
//                         let receiver = $("#receiver").clone().attr("id", "receiverq")
//                         receiver.children().first().text(message.body)
//                         $(".conversations").append(receiver)

//                     }
//                     window.scrollTo(0, document.body.scrollHeight)

//                 })
//                 setTimeout(() => {
//                     if (canceld) constantChecking();
//                 }, 500)

//             }

//         })
// }
// $("#cancel").click(function() {
//     canceld = false
// })

// function fetch_data() {
//     $.post("/message/getChats", { receiver: Reciever, pos: POS }, function(data) {
//         // alert(POS);
//         // alert(data)
//         let messages = JSON.parse(data)
//         console.log(messages)
//         chatState = messages[1]
//         messages[0].map(message => {
//             if (Number(message.sender) === Number(Sender)) {
//                 let sender = $("#sender").clone().attr("id", "senderq")
//                 sender.children().first().text(message.body)
//                 $(".conversations").append(sender)
//             } else if (Number(message.sender) === Number(Reciever)) {
//                 let receiver = $("#receiver").clone().attr("id", "receiverq")
//                 receiver.children().first().text(message.body)
//                 $(".conversations").append(receiver)
//             }
//             window.scrollTo(0, document.body.scrollHeight)
//         })
//         messages[2] ? $("#older").css("display", "none") : $("#older").css("display", "block")

//         constantChecking()
//     })
// }
// $("#newer").click(function() {
//     $("#conversations").empty();
//     POS -= 5;
//     fetch_data()
// })
// $("#older").click(function() {
//     $("#conversations").empty();
//     POS += 5;
//     fetch_data()
// })

// function redirect(e) {
//     canceld = true
//     $("#conversations").empty()
//     Reciever = /\d+/.exec(e.id)
//     Sender = /\d+/.exec(e.parentElement.id)
//     fetch_data()
// }

// function createFriendChat() {
//     $.post("/message/friendtochat", {}, function(data) {
//         // alert(data)
//         let passed = JSON.parse(data)
//         passed[0].map(username => {
//             let friend = $("#friendsTemplates")
//             if (username.id !== passed[1]) {
//                 let friends = friend.clone().click(function() {
//                     document.querySelector(".msg-sub-page").style.display = "none";
//                     document.querySelector(".chat-section").style.display = "block";
//                 })
//                 friends.attr("id", "friendsdata" + username.id)
//                 friends.children().eq(1).children().first().children().first().text(username.username)
//                 $(".messages").append(friends)
//             } else {
//                 friend.parent().parent().attr("id", "Message" + username.id)
//             }
//             friend.parent().parent().attr("id", "Message" + passed[1])
//         })
//     })
// }
// createFriendChat()
//     // inserts chat into the database 
// function insert() {
//     let input = $("[name=user-msg]")
//     if (input.val() == "") null;
//     else {
//         $.post("/message/sendchat", { receiver: Reciever, message: input.val() }, function(res) {
//             input.val("")
//         })
//     }
// }