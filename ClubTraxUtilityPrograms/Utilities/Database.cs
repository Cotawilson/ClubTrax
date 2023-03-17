using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Linq;
using System.Web;


namespace ClubTraxUtilityPrograms.Utilities
{
    public class Database : IDisposable

    {
        //private static Logger logger = LogManager.GetCurrentClassLogger();
        private SqlConnection connection;
        /// <summary>
        /// SqlConnection object to be used for making queries.
        /// </summary>
        public SqlConnection Connection
        {
            get { return connection; }
        }

        /// <summary>
        /// Creates a new database connection using the key to the connection string in the Web.config file
        /// </summary>
        /// <param name="Database">Key name of the connection string in the Web.config file</param>
        public Database(string Database)
        {
            connection = new SqlConnection(ConfigurationManager.ConnectionStrings[Database].ConnectionString);
            connection.Open();
        }

        public void Dispose()
        {
            if (Connection.State == System.Data.ConnectionState.Open)
            {
                try
                {
                    Connection.Dispose();
                }
                catch (Exception e)
                {

                    // logger.Log(LogLevel.Error, "Error in Database class", e);
                }
            }
        }





    }
}