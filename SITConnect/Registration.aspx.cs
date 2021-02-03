using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace SITConnect
{
    public partial class Registration : System.Web.UI.Page
    {
        DateTime dt = new DateTime();
        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private int checkPassword(string password)
        {
            int score = 0;

            if (password.Length < 8)
            {
                return 1;
            }
            else
            {
                score = 1;
            }

            if (Regex.IsMatch(password, "[a-z]"))
            {
                score++;
            }

            if (Regex.IsMatch(password, "[A-Z]"))
            {
                score++;
            }

            if (Regex.IsMatch(password, "[0-9]"))
            {
                score++;
            }

            if (Regex.IsMatch(password, "[^A-Za-z0-9]"))
            {
                score++;
            }

            return score;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            //For input validation
            if (tb_firstname.Text == "")
            {
                lb_msg.Text += "First Name cannot be empty <br/>";
            }

            if (tb_lastname.Text == "")
            {
                lb_msg.Text += "Last Name cannot be empty <br/>";
            }

            if (tb_credit.Text == "")
            {
                lb_msg.Text += "Credit Card Number cannot be empty <br/>";
            }

            if (tb_expiry.Text == "")
            {
                lb_msg.Text += "Expiry Date cannot be empty <br/>";
            }

            if (tb_cvv.Text == "")
            {
                lb_msg.Text += "CVV Number cannot be empty <br/>";
            }

            if (tb_email.Text == "")
            {
                lb_msg.Text += "Email address cannot be empty <br/>";
            }

            if (tb_dob.Text == "")
            {
                lb_msg.Text += "Date of Birth cannot be empty <br/>";
            }

            // implement codes for the button event
            // Extract data from textbox
            int scores = checkPassword(tb_password.Text);
            string status = "";
            switch (scores)
            {
                case 1:
                    status = "Very Weak Password!";
                    break;
                case 2:
                    status = "Weak Password!";
                    break;
                case 3:
                    status = "Need Better Password!";
                    break;
                case 4:
                    status = "Requires Special Characters";
                    break;
                default:
                    break;
            }

            lb_errpassword.Text = "Strength : " + status;
            if (scores < 5)
            {
                return;
            }
            else
            {
                
                dt = Convert.ToDateTime(DateTime.ParseExact(tb_dob.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture));

                //Codes for encrypting password and credit card
                string pwd = tb_password.Text.ToString().Trim();

                //Generate random "salt"
                RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                byte[] saltByte = new byte[8];

                //Fills array of bytes with a cryptographically strong sequence of random values.
                rng.GetBytes(saltByte);
                salt = Convert.ToBase64String(saltByte);
                SHA512Managed hashing = new SHA512Managed();
                string pwdWithSalt = pwd + salt;
                byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
                byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                finalHash = Convert.ToBase64String(hashWithSalt);
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.GenerateKey();
                Key = cipher.Key;
                IV = cipher.IV;
                createAccount();
                Response.Redirect("SuccessRegister.aspx", false);
            }
            

            
        }

        protected void createAccount()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(MYDBConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@Email, @First, @Last, @Credit, @Expiry, @CVV, @PasswordHash, @PasswordSalt, @DOB, @DateTimeRegistered)"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@Email", tb_email.Text.Trim());
                            cmd.Parameters.AddWithValue("@First", tb_firstname.Text.Trim());
                            cmd.Parameters.AddWithValue("@Last", tb_lastname.Text.Trim());
                            cmd.Parameters.AddWithValue("@Credit", Convert.ToBase64String(encryptData(tb_credit.Text.Trim())));
                            cmd.Parameters.AddWithValue("@Expiry", Convert.ToBase64String(encryptData(tb_expiry.Text.Trim())));
                            cmd.Parameters.AddWithValue("@CVV", Convert.ToBase64String(encryptData(tb_cvv.Text.Trim())));
                            cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
                            cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                            cmd.Parameters.AddWithValue("@DOB", dt);
                            cmd.Parameters.AddWithValue("@DateTimeRegistered", DateTime.Now);
                            cmd.Connection = con;
                            try
                            {
                                con.Open();
                                cmd.ExecuteNonQuery();
                                //con.Close();
                            }
                            catch (Exception ex)
                            {
                                //throw new Exception(ex.ToString());
                                lb_msg.Text = "Error occured";
                            }
                            finally
                            {
                                con.Close();
                            }
                            //con.Open();
                            //cmd.ExecuteNonQuery();
                            //con.Close();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
        }

        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                //ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }
    }
}