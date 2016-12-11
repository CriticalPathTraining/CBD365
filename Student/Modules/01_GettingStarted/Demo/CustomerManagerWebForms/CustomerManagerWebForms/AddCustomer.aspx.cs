using CustomerManagerWebForms.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CustomerManagerWebForms {
    public partial class AddCustomer : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void cmdAddCustomer_Click(object sender, EventArgs e) {

            ICustomerService customerService = new CustomerServiceInMemory();

            CustomerEntity newCustomer = new CustomerEntity {
                FirstName = txtFirstName.Text,
                LastName = txtLastName.Text,
                Company = txtCompany.Text,
                Email = txtEMailAddress.Text,
                WorkPhone = txtWorkPhone.Text,
                HomePhone = txtHomePhone.Text
            };

            customerService.Create(newCustomer);

            Response.Redirect("Customers");
        }
    }
}