using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.WindowsAzure.Storage.Table;
using Microsoft.WindowsAzure.Storage;
using System.Configuration;

namespace StorageApp1 {

    class CustomerEntity : TableEntity {
        private static int customerID = 0;
        private static string getNextCustomerID() {
            customerID++;
            return customerID.ToString("0000");
        }
        public CustomerEntity() {
            this.PartitionKey = "US Customers";
            this.RowKey = getNextCustomerID();
        }

        public CustomerEntity(string firstName, string lastName) {
            
            this.PartitionKey = "US Customers";
            this.RowKey = getNextCustomerID();

            this.FirstName = firstName;
            this.LastName = lastName;
        }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }

    class CustomerManager {
        private static CloudStorageAccount storageAccount;
        private static CloudTableClient tableClient;
        private static CloudTable customersTable;
        static CustomerManager() {
            storageAccount = CloudStorageAccount.Parse(ConfigurationManager.AppSettings["StorageConnectionString"]);
            tableClient = storageAccount.CreateCloudTableClient();
            customersTable = tableClient.GetTableReference("Customers");
            if (customersTable.Exists()) {
                customersTable.Delete();
            }
            customersTable.DeleteIfExists();
            customersTable.Create();
        }
        public static void AddCustomer(string FirstName, string LastName) {
            CustomerEntity newCustomer = new CustomerEntity(FirstName, LastName);
            TableOperation insertTableOperation = TableOperation.Insert(newCustomer);
            customersTable.Execute(insertTableOperation);
        }

        public static void DisplayCustomers() {
            TableQuery<CustomerEntity> query = new TableQuery<CustomerEntity>();
            foreach(var customer in customersTable.ExecuteQuery(query)) {
                Console.WriteLine("Customer: " + customer.FirstName + " " + customer.LastName);
                Console.WriteLine("PartitionKey: " + customer.PartitionKey);
                Console.WriteLine("RowKey: " + customer.RowKey);
                Console.WriteLine("Timestamp: " + customer.Timestamp);
                Console.WriteLine("ETag: " + customer.ETag);
                Console.WriteLine();
            }

        }
    }

}
