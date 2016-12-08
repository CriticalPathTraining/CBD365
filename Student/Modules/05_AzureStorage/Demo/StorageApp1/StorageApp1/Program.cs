using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Storage.Table;
using Microsoft.WindowsAzure.Storage.Queue;
using System.Configuration;
using System.IO;

namespace StorageApp1 {
    class Program {
        static void Main(string[] args) {
            //UploadBlobFile();
            //CreateTable();
            CreateQueue();
            //ProcessMessagesInQueue();
        }

        static void UploadBlobFile() {

            var storageAccount = CloudStorageAccount.Parse(ConfigurationManager.AppSettings["StorageConnectionString"]);
            CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();

            CloudBlobContainer container = blobClient.GetContainerReference("files");
            container.CreateIfNotExists();
            container.SetPermissions(new BlobContainerPermissions { PublicAccess = BlobContainerPublicAccessType.Blob });

            CloudBlockBlob blockBlob = container.GetBlockBlobReference("myfile.txt");
            MemoryStream stream = new MemoryStream();
            StreamWriter writer = new StreamWriter(stream);
            writer.Write("Hello world");
            writer.Flush();
            blockBlob.UploadText("Hello world");

        }
        static void CreateTable() {
           CustomerManager.AddCustomer("Frank", "Sinatra");
           CustomerManager.AddCustomer("Dean", "Martin");
           CustomerManager.AddCustomer("Sammy", "Davis Jr.");
           CustomerManager.DisplayCustomers();    
        }

        static void CreateQueue() {
            var storageAccount = CloudStorageAccount.Parse(ConfigurationManager.AppSettings["StorageConnectionString"]);
            CloudQueueClient queueClient = storageAccount.CreateCloudQueueClient();
            CloudQueue messageQueue = queueClient.GetQueueReference("spouse-chat");
            messageQueue.CreateIfNotExists();

            messageQueue.AddMessage(new CloudQueueMessage("Hi babe. Just got off work."));
            messageQueue.AddMessage(new CloudQueueMessage("I need to go to the pub to prep for Azure Certification exam."));
            messageQueue.AddMessage(new CloudQueueMessage("I'll be home as soon as I can."));

            foreach (var message in messageQueue.GetMessages(10)) {
                Console.WriteLine(message.AsString);
            }

        }

        static void ProcessMessagesInQueue() {
            var storageAccount = CloudStorageAccount.Parse(ConfigurationManager.AppSettings["StorageConnectionString"]);
            CloudQueueClient queueClient = storageAccount.CreateCloudQueueClient();
            CloudQueue messageQueue = queueClient.GetQueueReference("spouse-chat");

            foreach (var message in messageQueue.GetMessages(10)) {
                Console.WriteLine("You say '" + message.AsString + "'");
                Console.WriteLine("    Spouse says 'You gotta be friggin kidding me!'");
                messageQueue.DeleteMessage(message);
            }

        }

    }
}
