package model;

public class Booking {

    private int bookingId;
    private int rideId;
    private int passengerId;

    private int seatsBooked;

    private double farePerPerson;

    private String bookingStatus;

    // Default Constructor
    public Booking() {
    }

    // Parameterized Constructor
    public Booking(int bookingId, int rideId,
            int passengerId, int seatsBooked,
            double farePerPerson,
            String bookingStatus) {

        this.bookingId = bookingId;
        this.rideId = rideId;
        this.passengerId = passengerId;
        this.seatsBooked = seatsBooked;
        this.farePerPerson = farePerPerson;
        this.bookingStatus = bookingStatus;
    }

    // Getters and Setters

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getRideId() {
        return rideId;
    }

    public void setRideId(int rideId) {
        this.rideId = rideId;
    }

    public int getPassengerId() {
        return passengerId;
    }

    public void setPassengerId(int passengerId) {
        this.passengerId = passengerId;
    }

    public int getSeatsBooked() {
        return seatsBooked;
    }

    public void setSeatsBooked(int seatsBooked) {
        this.seatsBooked = seatsBooked;
    }

    public double getFarePerPerson() {
        return farePerPerson;
    }

    public void setFarePerPerson(double farePerPerson) {
        this.farePerPerson = farePerPerson;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }
}