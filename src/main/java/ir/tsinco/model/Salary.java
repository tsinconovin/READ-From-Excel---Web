package ir.tsinco.model;

public class Salary{
    private  long id;
    private  String firstName;
    private  String lastName;
    private   long amount;
    private  int year;
    private  int mounth;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public long getAmount() {
        return amount;
    }

    public void setAmount(long amount) {
        this.amount = amount;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return mounth;
    }

    public void setMonth(int mounth) {
        this.mounth = mounth;
    }
}
