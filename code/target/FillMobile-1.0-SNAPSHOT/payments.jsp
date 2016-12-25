<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="new_payment">
    <form method="post" action="/pay">
        <label>Select phone</label><input type="text" id="phone_input" name="phone_input">
        <label>Amount</label><input type="text" id="amount_input" name="amount_input">
        <p>Select bank card</p>
        <select name="card_select">
            <option label=" "></option>
            <c:forEach items="${requestScope.cards}" var="card">
            <option value="${card.getCardNo()}">${card.getCardNo()} - ${card.getName()}</option>
            </c:forEach>
        </select>

        <p>or input requisites</p>

        <div id="card_requisites">
            <div id="cards"><label>Card No</label><input type="text" id="card_input" name="card_input"></div>
            <label>Expire</label>
                <select id ="month_select" name="month_select">
                    <option value="1">01</option>
                    <option value="2">02</option>
                    <option value="3">03</option>
                    <option value="4">04</option>
                    <option value="5">05</option>
                    <option value="6">06</option>
                    <option value="7">07</option>
                    <option value="8">08</option>
                    <option value="9">09</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                </select>
                <select id="year_select" name="year_select">
                    <option value="16">16</option>
                    <option value="17">17</option>
                    <option value="18">18</option>
                </select>
            <label>CVV</label><input type="password" id="cvv_input" name="cvv_input">
        </div>
        <input type="submit">
    </form>
</div>
<div id="payments_history">
    <table>
        <tr>
            <th>#</th>
            <th>Phone</th>
            <th>Card Name</th>
            <th>Card #</th>
            <th>Amount</th>
            <th>Date</th>
        </tr>
        <c:set var="row_count" value="1" scope="page" />
    <c:forEach items="${requestScope.payments}" var="payment">
        <tr class="payment">
            <td class="row_num">${count}</td>
            <td class="payment_phone">${payment.getPhone()}</td>
            <td class="payment_CardName">${payment.getCard().getName()}</td>
            <td class="payment_CardNo">${payment.getCard().getCardNo()}</td>
            <td class="payment_amount">${payment.getAmount()}</td>
            <td class="payment_amount">${payment.getDate()}</td>
        </tr>
        <c:set var="count" value="${count + 1}" scope="page"/>
    </c:forEach>
    </table>
</div>