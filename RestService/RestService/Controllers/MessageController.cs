using RestServiceBLL;
using RestServiceModel;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace RestService.Controllers
{
    public class MessageController : ApiController
    {
        /// <summary>
        /// Post the Specified Message & Return Total Message Counts
        /// </summary>
        /// <param name="messg"></param>
        /// <returns>Message Counts</returns>
        // POST: api/Message
        public HttpResponseMessage Post([FromBody]Message message)
        {
            if (!ModelState.IsValid || message == null)
            {
                return new HttpResponseMessage(HttpStatusCode.BadRequest)
                {
                    Content = new StringContent("Bad Request")

                };
            }
            try
            {
                MessageBAL _messageBAL = new MessageBAL();
                var result = _messageBAL.Message(message);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return new HttpResponseMessage(HttpStatusCode.InternalServerError)
                {
                    Content = new StringContent(ex.Message)

                };
            }
        }
    }
}
