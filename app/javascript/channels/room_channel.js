// import consumer from "./consumer"

// consumer.subscriptions.create("RoomChannel", {
//   connected() {

//     console.log("hlo")
//     // Called when the subscription is ready for use on the server
//   },

//   disconnected() {
//     // Called when the subscription has been terminated by the server
//   },

//   received(data) {
//     $("#msg").append('<span class="message">'+ data.content + '</span>')
//     console.log(data.content);

//     // Called when there's incoming data on the websocket for this channel
//   }
// });


import consumer from "./consumer"

let roomSubscription = null

document.addEventListener("turbolinks:load", () => {
  const messagesDiv = document.getElementById("messages")
  if (!messagesDiv) return

  const conversationId = messagesDiv.dataset.conversationId
  const currentUserId = document.body.dataset.currentUserId

  if (!conversationId) {
    console.error(" conversation_id missing from DOM")
    return
  }


  if (roomSubscription) {
    consumer.subscriptions.remove(roomSubscription)
    roomSubscription = null
  }

  roomSubscription = consumer.subscriptions.create(
    {
      channel: "RoomChannel",
      conversation_id: conversationId
    },
    {
      connected() {
        console.log(" Connected to RoomChannel:", conversationId)
      },

      disconnected() {
        console.log("Disconnected from RoomChannel")
      },

      // received(data) {
      //   const isMe = String(data.sender_id) === String(currentUserId)


      //   const html = `
      //     <div class="clearfix">
      //       <div class="${isMe ? 'pull-right text-right' : 'pull-left'}"
      //            style="max-width:70%; margin-bottom:10px;">
      //         <span class="label ${isMe ? 'label-primary' : 'label-default'}">
      //           ${isMe ? 'You' : data.sender_name}
      //         </span>
              
      //         <div class="well well-sm "
      //              style="margin-top:5px; ${isMe ? 'background:#FDC600;color:white;' : ''}">
      //           ${data.content}
      //         </div>
      //       </div>
      //     </div>
      //   `

      //   messagesDiv.insertAdjacentHTML("beforeend", html)
      //   // messagesDiv.scrollTop = messagesDiv.scrollHeight

      //   requestAnimationFrame(() => {
      //     messagesDiv.scrollTop = messagesDiv.scrollHeight
      //   })
      // }
      received(data) {
        const isMe = String(data.sender_id) === String(currentUserId);
        console.log(currentUserId);
        // Use a temporary element to escape the content
        const div = document.createElement('div');
        div.textContent = data.content;
        const safeContent = div.innerHTML;

        const html = `
          <div class="clearfix">
            <div class="${isMe ? 'pull-right text-right' : 'pull-left'}" style="max-width:70%; margin-bottom:10px;">
              <span class="label ${isMe ? 'label-primary' : 'label-default'}">${isMe ? 'You' : data.sender_name}</span>
              <div class="well well-sm" style="margin-top:5px; ${isMe ? 'background:#FDC600;color:white;' : ''}">
                ${safeContent}
              </div>
            </div>
          </div>`;
        
        messagesDiv.insertAdjacentHTML("beforeend", html);
        requestAnimationFrame(() => {
          messagesDiv.scrollTop = messagesDiv.scrollHeight
        })
      }
    }
  )
})

document.addEventListener("turbolinks:before-cache", () => {
  if (roomSubscription) {
    consumer.subscriptions.remove(roomSubscription)
    roomSubscription = null
  }
})