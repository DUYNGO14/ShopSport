// Script for navigation bar
const bar = document.getElementById('bar')
const navbar = document.getElementById('navbar')
const close = document.getElementById('close')
if (bar) {
    bar.addEventListener('click', () => {
        navbar.classList.add('active')
    })
}

if (close) {
    close.addEventListener('click', () => {
        navbar.classList.remove('active')
    })
}



(function ($) {
    $('.quantity button').on('click', function () {
        let change = 0;

        var button = $(this);
        var oldValue = button.parent().parent().find('input').val();
        if (button.hasClass('btn-plus')) {
            var newVal = parseFloat(oldValue) + 1;
            change = 1;
        } else {
            if (oldValue > 1) {
                var newVal = parseFloat(oldValue) - 1;
                change = -1;
            } else {
                newVal = 1;
            }
        }
        const input = button.parent().parent().find('input');
        input.val(newVal);

        //set form index
        const index = input.attr("data-cart-detail-index")
        const el = document.getElementById(`lstCartDetail${index}.quantity`);
        $(el).val(newVal);



        //get price
        const price = input.attr("data-cart-detail-price");
        const id = input.attr("data-cart-detail-id");

        const priceElement = $(`p[data-cart-detail-id='${id}']`);
        if (priceElement) {
            const newPrice = +price * newVal;
            priceElement.text(formatCurrency(newPrice.toFixed(2)) + " đ");
        }

        //update total cart price
        const totalPriceElement = $(`p[data-cart-total-price]`);

        if (totalPriceElement && totalPriceElement.length) {
            const currentTotal = totalPriceElement.first().attr("data-cart-total-price");
            let newTotal = +currentTotal;
            if (change === 0) {
                newTotal = +currentTotal;
            } else {
                newTotal = change * (+price) + (+currentTotal);
            }

            //reset change
            change = 0;

            //update
            totalPriceElement?.each(function (index, element) {
                //update text
                $(totalPriceElement[index]).text(formatCurrency(newTotal.toFixed(2)) + " đ");

                //update data-attribute
                $(totalPriceElement[index]).attr("data-cart-total-price", newTotal);
            });
        }
    });
    $(document).ready(function () {
        const navElement = $("#navbar");
        const currentUrl = window.location.pathname;
        navElement.find('li a.navbar-link').each(function () {
            const link = $(this);
            const href = link.attr('href');
            if (href === currentUrl) {
                link.addClass('active');
            } else {
                link.removeClass('active');
            }
        });
    });

    $(document).ready(function () {
        $('#mySelect').change(function () {
            var selectsize = $('#mySelect option:selected');
            const el1 = document.getElementById('lstCartDetail0.size');
            $(el1).val(selectsize.val());
        });
    });
    $(document).ready(function () {
        //add active class to header
        const navElement = $("#navbarCollapse");
        const currentUrl = window.location.pathname;
        navElement.find('a.navbar-link').each(function () {
            const link = $(this); // Get the current link in the loop
            const href = link.attr('href'); // Get the href attribute of the link

            if (href === currentUrl) {
                link.addClass('active'); // Add 'active' class if the href matches the current URL
            } else {
                link.removeClass('active'); // Remove 'active' class if the href does not match
            }
        });
    });

    function formatCurrency(value) {
        // Use the 'vi-VN' locale to format the number according to Vietnamese currency format
        // and 'VND' as the currency type for Vietnamese đồng
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'decimal',
            minimumFractionDigits: 0, // No decimal part for whole numbers
        });

        let formatted = formatter.format(value);
        // Replace dots with commas for thousands separator
        formatted = formatted.replace(/\./g, ',');
        return formatted;
    }

    $('#btnFilter').click(function (event) {
        event.preventDefault();
        let factoryArr = [];
        let categoryArr = [];
        $("#factoryFilter .form-check-input:checked").each(function () {
            factoryArr.push($(this).val());
        });
        $("#categoryFilter .form-check-input:checked").each(function () {
            categoryArr.push($(this).val());
        });
        let sortValue = $('input[name="radio-sort"]:checked').val();

        const currentUrl = new URL(window.location.href);
        const searchParams = currentUrl.searchParams;
        searchParams.set('page', '1');
        searchParams.set('sort', sortValue);
        //reset
        searchParams.delete('factory');
        searchParams.delete('category');
        // searchParams.delete('target');
        // searchParams.delete('price');
        if (factoryArr.length > 0) {
            searchParams.set('factory', factoryArr.join(','));
        }

        if (categoryArr.length > 0) {
            searchParams.set('category', categoryArr.join(','));
        }
        console.log(currentUrl)
        debugger
        window.location.href = currentUrl.toString();

    });

    const params = new URLSearchParams(window.location.search);
    if (params.has('factory')) {
        const factories = params.get('factory').split(',');
        factories.forEach(factory => {
            $(`#factoryFilter .form-check-input[value="${factory}"]`).prop('checked', true);
        });
    }
    if (params.has('category')) {
        const categories = params.get('category').split(',');
        categories.forEach(category => {
            $(`#categoryFilter .form-check-input[value="${category}"]`).prop('checked', true);
        });
    }
    // Set radio buttons for 'sort'
    if (params.has('sort')) {
        const sort = params.get('sort');
        $(`input[type="radio"][name="radio-sort"][value="${sort}"]`).prop('checked', true);
    }
})(jQuery);