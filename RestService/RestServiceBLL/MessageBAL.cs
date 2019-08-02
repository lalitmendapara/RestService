using RestServiceDAL;
using RestServiceModel;

namespace RestServiceBLL
{
    public class MessageBAL
    {
      
        MessageDAL _messageDAL = new MessageDAL();
        public ResponceMessage Message(Message messg)
        {
            return _messageDAL.Message(messg);
        }
    }
}
