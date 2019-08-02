using RestServiceModel;
using System;
using System.Data;
using System.Data.SqlClient;

namespace RestServiceDAL
{
    public class MessageDAL
    {
        public ResponceMessage Message(Message messg)
        {
            ResponceMessage _responceMessage = new ResponceMessage();
            try
            {
                using (SqlConnection _con = CommonSqlDAO.GetConnection())
                {
                    using (SqlCommand cmd = new SqlCommand("USP_ServiceMessage", _con))
                    {

                        cmd.Parameters.AddWithValue("@Id", messg.Id);
                        cmd.Parameters.AddWithValue("@Message", messg.message);
                        cmd.Parameters.Add("@TotalCount", SqlDbType.Int);
                        cmd.Parameters["@TotalCount"].Direction = ParameterDirection.Output;
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                        if (cmd.Parameters["@TotalCount"].Value != null)
                            _responceMessage.count = Convert.ToInt32(cmd.Parameters["@TotalCount"].Value);
                    }
                }
            }           
            finally
            {
                CommonSqlDAO.CloseConnection();
            }
            return _responceMessage;
        }
    }
}
