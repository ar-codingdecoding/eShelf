package eShelf;

import java.util.Date;

public class BorrowInfo {
    private int borrowId;
    private int bookId;
    private String bookName;
    private Date startDate;
    private Date finishDate;

    public int getBorrowId() { return borrowId; }
    public void setBorrowId(int borrowId) { this.borrowId = borrowId; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public String getBookName() { return bookName; }
    public void setBookName(String bookName) { this.bookName = bookName; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getFinishDate() { return finishDate; }
    public void setFinishDate(Date finishDate) { this.finishDate = finishDate; }
}
