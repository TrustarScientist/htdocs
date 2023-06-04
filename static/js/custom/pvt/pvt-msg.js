//
$(".msg-paths .control .my-people-btn").click(function() {
    $(".msg-paths .control").css("display", "none");
    $(".msg-paths .search-my-people-con").css("display", "flex");
    $(".incoming-messages").css("display", "none");
    $(".my-people-section").css("display", "block");
    $(".my-people-search-results").css("display", "block");

})
$(".msg-paths .my-people-cancel").click(function() {
    $(".msg-paths .control").css("display", "flex");
    $(".msg-paths .search-my-people-con").css("display", "none");
    $(".incoming-messages").css("display", "block");
    $(".my-people-section").css("display", "none");
    $(".my-people-search-results").css("display", "none");
})

/**
 *  mobile code
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
// hide conversation sub page
$(".chat-pane .cancel").click(function() {
    if (getWidth()) {
        $(".chat-board").css("display", "none");
        $(".incoming-messages-section").css("display", "block");
    } else {
        // do nothing...i guess.
    }
});




function getWidth() {
    return window.innerWidth;
}

/**
 *  populate current messages
 */

let incomingMessagesCon = document.querySelector(".incoming-messages");
let conversationCon = document.querySelector(".chat-board .conversations");
// first messages display
iMsgFetcher();



/** 
 * helper functions
 */

function iMsgFetcher() {
    $.post("/message/inbox", {}, function(data, status) {
        alert(data);
        // let incomingMessages = JSON.parse(data);
        // incomingMessages.forEach(iMsg => {
        //     msgMaker(iMsg);
        // });

    });
}

function chatFandP(sender = -1, receiver = 0, starting = 0, amount = 3) {
    $.post("/message/conversation", {

        sender,
        starting,
        amount

    }, function(data, status) {
        alert(data);
        let chats = JSON.parse(data);
        chats.forEach(chat => {
            console.log(chat);
        });
    });
}

function msgMaker(msg) {
    // console.log(msg)
    $.post("/user/profile/self", {}, (data, status) => {
        // current user id
        let cUserId = (JSON.parse(data).id)

        //console.log(msg)
        let newMsg = document.createElement("article");
        newMsg.setAttribute("class", "incoming-msg");
        newMsg.setAttribute("data-msg-id", msg.id);
        newMsg.setAttribute("data-sender-id", msg.sender.id);


        // add event handler on the new msg
        newMsg.addEventListener("click", function() {
            conversationCon.innerHTML = "";
            //fetch the conversation between the current user and the sender
            chatFandP(sender = msg.sender.id);
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

    })
}




// messaging sending functionality
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
});






// $.post("/message/inbox", {}, function(data, status) {

//     console.log(data);
//     let incomingMessages = JSON.parse(data);

//     let unique = [];
//     let distinct = [];
//     for (let index = 0; index < incomingMessages.length; index++) {

//         if (!unique[incomingMessages[index].sender.id]) {
//             distinct.push(incomingMessages[index]);
//             unique[incomingMessages[index].sender.id] = 1;
//         }
//     }
//     // console.log(distinct);
//     distinct.forEach(dMsg => {
//         msgMaker(dMsg);
//     });
//     let lastMessageDate = distinct[0].datetime;

// });