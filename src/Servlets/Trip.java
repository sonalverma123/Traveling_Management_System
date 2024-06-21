package Servlets;

import java.util.Date;

public class Trip {
    private int tripId;
    private String origin;
    private String destination;
    private Date departureDate;
    private Date returnDate;
    private int numberOfTravelers;
    private String preferredAirline;
    private String hotelType;
    private String carRentalType;
    
	public int getTripId() {
		return tripId;
	}
	public void setTripId(int tripId) {
		this.tripId = tripId;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public Date getDepartureDate() {
		return departureDate;
	}
	public void setDepartureDate(Date departureDate) {
		this.departureDate = departureDate;
	}
	public Date getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}
	public int getNumberOfTravelers() {
		return numberOfTravelers;
	}
	public void setNumberOfTravelers(int numberOfTravelers) {
		this.numberOfTravelers = numberOfTravelers;
	}
	public String getPreferredAirline() {
		return preferredAirline;
	}
	public void setPreferredAirline(String preferredAirline) {
		this.preferredAirline = preferredAirline;
	}
	public String getHotelType() {
		return hotelType;
	}
	public void setHotelType(String hotelType) {
		this.hotelType = hotelType;
	}
	public String getCarRentalType() {
		return carRentalType;
	}
	public void setCarRentalType(String carRentalType) {
		this.carRentalType = carRentalType;
	}
}