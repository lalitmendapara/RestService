using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace RestServiceDAL
{
    public class CommonSqlDAO
    {
        private static SqlConnection objConn = null;

        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["RestServiceConnection"].ConnectionString;
        }

        public static SqlConnection GetConnection()
        {
            if (objConn != null && objConn.State == ConnectionState.Open)
            {
                return objConn;
            }

            else if (objConn != null && objConn.State == ConnectionState.Closed && !string.IsNullOrEmpty(objConn.ConnectionString))
            {
                objConn.Open();
                return objConn;
            }
            else
            {
                objConn = new SqlConnection();
                objConn.ConnectionString = GetConnectionString();
                objConn.Open();
                return objConn;
            }
        }

        public static void CloseConnection()
        {
            if (objConn != null)
            {
                if (objConn.State == ConnectionState.Open)
                {
                    objConn.Close();
                }
            }
        }
    }
}
