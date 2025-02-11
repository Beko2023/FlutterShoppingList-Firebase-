Note - we have implemented a FutureBuilder on the grocery list page which was for illustration purposes alone. Hence, I've included both pages as a note for reference. FutureBuilder, while great to conditionally render a complex page with live data fed to it for rendering and rendering alone; it's use case here is arguably redundant due to the multi-screen information flow required for our grocery list screen.

Here are some examples to the error handling we've implemented below; 

Server side read and write access has been granted. We can POST, DELETE, and GET data just fine.
![image](https://github.com/user-attachments/assets/9f4974f6-eeac-4efa-9b87-dce3363ad36e)

However, denied access results in home page returning a prompt rather than the App crash.
![image](https://github.com/user-attachments/assets/9cd50e08-d0fa-46da-98fd-d3e0926e5f38)

Similarly, I added a TRY and CATCH to our submission page to render a message.
![image](https://github.com/user-attachments/assets/9bc4856e-b8b1-4ec1-aae7-f85eaa4d1aa4)

Other minor adjustments have been implemented. For instance, if a future returns null like above, dismissible items will return to their original list index in the grocery items list. 
