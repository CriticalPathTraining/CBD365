using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CustomerManagerWebForms.Models;

namespace CustomerManagerWebForms {
    public partial class Customers : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            ICustomerService customerService = new CustomerServiceInMemory();
            var CustomerList = customerService.GetCustomers();

            gridCustomers.DataSource = CustomerList;
            gridCustomers.DataBind();

        }
    }
}