public class AddmultipleAccountsController {
	Account account = new Account();
	public list<Account> listAccount{ get; set; }

	public AddmultipleAccountsController() {
		listAccount=new list<Account>();
		listAccount.add(account);
	}

	Public void addAccount() {
		Account acc = new Account();
		listAccount.add(acc);
	}Public PageReference saveAccount()
{
insert listAccount;
return Null;
}
    }