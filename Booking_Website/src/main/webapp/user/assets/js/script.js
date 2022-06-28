$(function () {

    'use strict';

    $('.js-menu-toggle').click(function (e) {

        var $this = $(this);


        if ($('body').hasClass('show-sidebar')) {
            $('body').removeClass('show-sidebar');
            $this.removeClass('active');
        } else {
            $('body').addClass('show-sidebar');
            $this.addClass('active');
        }

        e.preventDefault();

    });

    // click outisde offcanvas
    $(document).mouseup(function (e) {
        var container = $(".sidebar");
        if (!container.is(e.target) && container.has(e.target).length === 0) {
            if ($('body').hasClass('show-sidebar')) {
                $('body').removeClass('show-sidebar');
                $('body').find('.js-menu-toggle').removeClass('active');
            }
        }
    });

});
$(document).ready(function () {
        // ---------home-page
        $('#type-hotel').owlCarousel({
            loop: true, margin: 10, nav: true, autoplay: true, responsive: {
                0: {
                    items: 1
                }, 600: {
                    items: 3
                }, 1000: {
                    items: 5
                }
            }
        })

        $('#random-hotel1').owlCarousel({
            loop: true, margin: 10, nav: true, autoplay: true, autoplayTimeout: 8000, responsive: {
                0: {
                    items: 1
                }, 600: {
                    items: 2
                }, 1000: {
                    items: 3
                }
            }
        })

        $('#random-hotel2').owlCarousel({
            loop: true, margin: 10, nav: true, autoplay: true, autoplayTimeout: 8000, responsive: {
                0: {
                    items: 1
                }, 600: {
                    items: 2
                }, 1000: {
                    items: 3
                }
            }
        })

        // -----------my-account
        $('#booking-history').DataTable({
            lengthMenu: [[5, 10, 25], [5, 10, 25]]
        });

        var rating;
        $('#star1').starrr({
            change: function (e, value) {
                if (value) {
                    $('.your-choice-was').show();

                    let status = '';
                    if (value == 5) {
                        status = 'Rất tốt';
                    } else if (value == 4) {
                        status = 'Tốt';
                    } else if (value == 3) {
                        status = 'Hài Lòng';
                    } else if (value == 2) {
                        status = 'Kém';
                    } else if (value == 1) {
                        status = 'Rất kém';
                    }
                    $('.choice').text(status);
                    rating = value;
                } else {
                    $('.your-choice-was').hide();
                }
            }
        });

        $(".rating-btn").click(function () {
            const bookingId = $(this).parent().find('input[name="bookingId"]').val();
            $('#rating-modal .modal-footer input[name="bookingId"]').val(bookingId);
        });

        $('.rating-modal-btn').on('click', function () {
            const bookingId = $('#rating-modal .modal-footer input[name="bookingId"]').val();
            let title = $("#rating-modal input[name='title']").val();
            let description = $("#rating-modal textarea[name='description']").val();

            ratingModalAPI(bookingId, rating, title, description);
        });

        function ratingModalAPI(bookingId, rating, title, description) {
            $.ajax({
                url: "my-account?action=addNewRating",
                type: "post",
                data: {
                    bookingId: bookingId,
                    rating: rating,
                    title: title,
                    description: description
                },
                success: function () {
                    swal("Cảm ơn bạn đã gửi đánh giá!", "", "success");
                }
            });
        }


        //------------ datepicker
        flatpickr("input[name=datepicker1", {
            allowInput: true,
            onReady: function (selectedDates, dateStr, instance) {
                let el = instance.element;

                function preventInput(event) {
                    event.preventDefault();
                    return false;
                };
                el.onkeypress = el.onkeydown = el.onkeyup = preventInput; // disable key events
                el.onpaste = preventInput; // disable pasting using mouse context menu

                el.style.caretColor = 'transparent'; // hide blinking cursor
                el.style.cursor = 'pointer'; // override cursor hover type text
            },
            minDate: "today",
            dateFormat: "d M Y",
            "plugins": [new rangePlugin({input: "input[name=datepicker2"})]
        });

        flatpickr("input[name=datepicker2", {
            minDate: "today",
            dateFormat: "d M Y",
            "plugins": [new rangePlugin({input: "input[name=datepicker1"})]
        });

        flatpickr("input[name=dateOfBirth", {
            dateFormat: "d M Y"
        });


        // Search-result
        var filterCheck = [];
        var filterSort;

        $('.filter-check').on('change', function () {
            if (getStoredValue("filterCheck") != null) {
                filterCheck = getStoredValue("filterCheck");
                filterCheck = JSON.parse(filterCheck);
                localStorage.removeItem("filterCheck");
            }
            if (this.checked) {
                filterCheck.push($(this).val());
                if (checkIfDuplicateExists(filterCheck)) {
                    filterCheck.pop();
                }
            } else {
                removeItemOnce(filterCheck, $(this).val());
            }
            filterSearchHotelAPI(filterCheck, filterSort, "");
        });

        $('.filter-sort').on('change', function () {
            filterSort = $('.filter-sort :checked').val();
            filterSearchHotelAPI(filterCheck, filterSort, "");
        });

        $(document).on('click', ".search-result-pagination .page-link", function () {
            const index = $(this).parent().find('input[name="index"]').val();
            if (getStoredValue("filterCheck") != null) {
                filterCheck = getStoredValue("filterCheck");
                filterCheck = JSON.parse(filterCheck);
                localStorage.removeItem("filterCheck");
            }
            filterSearchHotelAPI(filterCheck, filterSort, index);
        })

        //home hotel-type-btn
        $('.hotel-type-btn').on('click', function () {
            filterCheck.push($(this).parent().find('input[name="hotelTypeId"]').val());
            storeValue("filterCheck", filterCheck);
        });

        //home city-btn
        $('.city-btn').on('click', function () {
            filterCheck.push($(this).parent().find('input[name="cityId"]').val());
            storeValue("filterCheck", filterCheck);
        });

        //store value after reload page
        function storeValue(key, value) {
            if (localStorage) {
                localStorage.setItem(key, JSON.stringify(value));
            } else {
                $.cookies.set(key, value);
            }
        }

        //get value after reload page
        function getStoredValue(key) {
            if (localStorage) {
                return localStorage.getItem(key);
            } else {
                return $.cookies.get(key);
            }
        }


        function checkIfDuplicateExists(arr) {   //check if duplicate in arr
            return new Set(arr).size !== arr.length;
        }

        function removeItemOnce(arr, value) {   //remove an item by index
            var index = arr.indexOf(value);
            if (index > -1) {
                arr.splice(index, 1);
            }
            return arr;
        }

        function filterSearchHotelAPI(filterCheck, filterSort, index) {
            $.ajax({
                url: "filter-search",
                type: "post",
                dataType: 'json',
                data: {
                    index: index,
                    filterCheck: filterCheck,
                    filterSort: filterSort
                },
                success: function (result) {
                    renderSearchResultFilter(result);
                }, error: function (e) {
                    console.log(e);
                }
            });
        }

        function renderSearchResultFilter(result) {
            $('.count-result').html('                            <h3 class="m-0 font-weight-bold">\n' +
                '                                Kết quả: tìm thấy ' + result.countResult + ' chỗ nghỉ\n' +
                '                            </h3>');

            $(".list-search-result").html(result.content);

            let pagination;
            pagination = '                <div class="pagination-area wow fadeInUp search-result-pagination" data-wow-delay="400ms ">\n' +
                '                    <nav>\n' +
                '                        <ul class="pagination ">';
            if (result.lastPage < 1 || result.index > result.lastPage) {
                pagination += '<h1>Not found</h1>';
            } else {
                for (let i = 1; i <= result.lastPage; i++) {
                    pagination += '                                    <li class="page-item ' + (i == result.index ? "active" : "") + ' ">\n' +
                        '                                        <input type="hidden" name="index" value="' + i + '">\n' +
                        '                                        <div class="page-link ">0' + i + '.</div>\n' +
                        '                                    </li>';
                }
            }
            pagination += '                        </ul>\n' +
                '                    </nav>\n' +
                '                </div>\n';
            $('#result-pagination').html(pagination);
        }


        //---------Room
        $('#passenger-box input[type="number"]').inputSpinner({
            buttonsOnly: true,
            autoInterval: undefined
        });

        $('#room-input').on('input', function (e) {
            $('#room-lbl').html($(this).val());
        });

        $('#person-input').on('input', function (e) {
            $('#person-lbl').html($(this).val());
        });

        $(".dropdown-menu").click(function (e) {
            e.stopPropagation();
        })


        lightGallery(document.getElementById('animated-thumbnails-gallery'), {
            plugins: [lgThumbnail],
            thumbnail: true
        });

        $(".room-detail-btn").click(function () {
            const id = $(this).parent().find("input").val();
            roomPostAPI(id);
        });

        function roomPostAPI(id) {
            $.ajax({
                url: "room?action=loadRoomByAjax",
                type: "post",
                data: {
                    roomId: id
                },
                success: function (result) {
                    renderModal(result)
                }
            });
        }

        function renderModal(result) {
            var context = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
            var room = $.parseJSON(result);

            // image
            const image = room.roomImage.split("|");

            let img = "";
            for (let i = 0; i < image.length; i++) {
                if (image[i] !== '') {
                    img += '<div class=\"carousel-item ';
                    if (i == 0) {
                        img += 'active';
                    }
                    img += '">\n' +
                        '                                            <img src="' + (context + '/uploads/room/' + image[i]) + '">\n' +
                        '                                        </div>';
                }
            }
            $("#carouselExampleCaptions .carousel-inner").html(img);

            img = '';
            for (let i = 0; i < image.length; i++) {
                if (image[i] !== '') {
                    img += '<li data-target="#carouselExampleCaptions" data-slide-to="' + i + '" class="col-2 p-0 mx-1 ';
                    if (i == 0) {
                        img += 'active';
                    }
                    img += '">\n' +
                        '                                            <img class="d-block w-100 p-1" src="' + (context + '/uploads/room/' + image[i]) + '">\n' +
                        '                                        </li>';
                }
            }
            $("#carouselExampleCaptions .carousel-indicators").html(img);
            // content
            let content = '<div>\n' +
                '                                    <h4 class="modal-title font-weight-bold mb-2">\n' +
                '                                        ' + room.roomType + '\n' +
                '                                    </h4>\n' +
                '                                </div>\n' +
                '\n' +
                '                                <style>\n' +
                '                                    .service-box {\n' +
                '                                        display: inline-flex;\n' +
                '                                        margin-bottom: 3px;\n' +
                '                                    }\n' +
                '\n' +
                '                                    .service-box span {\n' +
                '                                        padding: 0px 2px;\n' +
                '                                        border: 1px solid #949494;\n' +
                '                                        border-radius: 2px;\n' +
                '                                    }\n' +
                '                                </style>\n' +
                '                                <div class="mb-3">\n' +
                '                                    <div class="service-box">\n' +
                '                                        <span><i class="fa-solid fa-house"></i>' + room.area + ' m<sup>2</sup></span>\n' +
                '                                    </div>\n' +
                '                                    <div class="service-box">\n' +
                '                                        <span><i class="fa-solid fa-droplet"></i>Điều hòa không khí</span>\n' +
                '                                    </div>\n' +
                '                                    <div class="service-box">\n' +
                '                                        <span><i class="fa-solid fa-bath"></i>Phòng tắm riêng</span>\n' +
                '                                    </div>\n' +
                '                                    <div class="service-box">\n' +
                '                                        <span><i class="fa-solid fa-tv"></i>TV màn hình phẳng</span>\n' +
                '                                    </div>\n' +
                '                                    <div class="service-box">\n' +
                '                                        <span><i class="fa-solid fa-volume-xmark"></i>Hệ thống cách âm</span>\n' +
                '                                    </div>\n' +
                '                                    <div class="service-box">\n' +
                '                                        <span><i class="fa-solid fa-wifi"></i>WiFi miễn phí</span>\n' +
                '                                    </div>\n' +
                '                                </div>\n' +
                '                                <div class="mb-3">\n' +
                '                                    <p class="text-dark m-0" style="font-size: 15px;"><strong>Kích thước phòng</strong> ' + room.area + ' m<sup>2</sup></p>\n' +
                '                                </div>\n' +
                '                                <div class="mb-3">\n' +
                '                                    <p class="text-dark m-0" style="font-size: 15px;"><strong>Phù hợp cho: </strong> ';

            if (room.suitableFor <= 2) {
                content += '<i class="fa-solid fa-user"></i><i class="fa-solid fa-user"></i>';
            } else {
                content += room.suitableFor + ' x <i class="fa-solid fa-user"></i>';
            }

            content += '</p>\n' +
                '                                </div>\n';

            if (room.view !== null && room.view !== "") {
                content += '                                <div class="mb-3 row">\n' +
                    '                                    <p class="col-12 text-dark m-0" style="font-size: 15px;"><strong>Hướng tầm nhìn:</strong></p>\n' +
                    '                                    <ul class="col" style="column-count: 2;">';
                const vie = room.view.split("|");
                for (let i = 0; i < vie.length; i++) {
                    content += '<li>\n' +
                        '                                            <i class="fa-solid fa-check mr-2 text-success"></i>' + vie[i] + '\n' +
                        '                                        </li>';
                }

                content += '</ul>\n' +
                    '                                </div>\n';
            }

            content += '                                <div class="mb-3 row">\n' +
                '                                    <p class="col-12 text-dark m-0" style="font-size: 15px;"><strong>Trong phòng tắm riêng của bạn:</strong></p>\n' +
                '                                    <ul class="col" style="column-count: 2;">';
            const bath = room.bathroom.split("|");
            for (let i = 0; i < bath.length; i++) {
                content += '<li>\n' +
                    '                                            <i class="fa-solid fa-check mr-2 text-success"></i>' + bath[i] + '\n' +
                    '                                        </li>';
            }

            content += '\n' +
                '                                    </ul>\n' +
                '                                </div>\n';

            if (room.dinningroom !== null && room.dinningroom !== "") {
                content += '<div class="mb-3 row">\n' +
                    '                                        <p class="col-12 text-dark m-0" style="font-size: 15px;"><strong>Nhà bếp:</strong></p>\n' +
                    '                                        <ul class="col" style="column-count: 2;">';
                const dinningroom = room.dinningroom.split("|");
                for (let i = 0; i < dinningroom.length; i++) {
                    content += '<li><i class="fa-solid fa-check mr-2 text-success"></i>' + dinningroom[i] + '\n<li>\n';
                }
                content += '</ul>\n' +
                    '                                    </div>\n';
            }

            content += '                                <div class="mb-3 row">\n' +
                '                                    <p class="col-12 text-dark m-0" style="font-size: 15px;"><strong>Tiện nghi phòng:</strong></p>\n' +
                '                                    <ul class="col" style="column-count: 2;">';
            const roomService = room.roomService.split("|");
            for (let i = 0; i < roomService.length; i++) {
                content += ' <li>\n' +
                    '                                            <i class="fa-solid fa-check mr-2 text-success"></i>' + roomService[i] + '\n' +
                    '                                        </li>';
            }

            content += '</div>\n' +
                '                                <div class="mb-3 row">\n' +
                '                                    <p class="col-12 text-dark m-0" style="font-size: 15px;"><strong>Hút thuốc: </strong>';
            if (room.smoke == false) {
                content += 'Không';
            } else {
                content += 'Có';
            }
            content += ' hút thuốc</p>\n' +
                '                                </div>\n' +
                '                                <div class="mb-3 row">\n' +
                '                                    <p class="col-12 text-dark m-0" style="font-size: 15px;"><strong>Chỗ đậu xe: </strong>Không có chỗ đỗ xe.</p>\n' +
                '                                </div>';
            $("#room-modal #content").html(content);

            const subDate = document.getElementsByName("subDate")[0].value;
            const lastPrice = parseFloat(room.price) * subDate * (100 - parseInt(room.discountPercent)) / 100;
            let lastPriceRight = '<div>\n' +
                '                                    <span class="text-danger mr-2"\n' +
                '                                          style="text-decoration: line-through;">VND ' + (Math.trunc(room.price * subDate)).toLocaleString('pl-PL') + ' </span><span\n' +
                '                                        class="bg-danger text-white rounded" style="padding: 2px 5px;">-' + room.discountPercent.toLocaleString('pl-PL') + '%</span>\n' +
                '                                </div>\n' +
                '                                <strong class="text-success mb-2" style="font-size: 20px;">VND ' + Math.trunc(lastPrice).toLocaleString('pl-PL') + ' cho ' + subDate + '\n' +
                '                                    đêm</strong>\n' +
                '                                <input type="hidden" value="' + room.roomId + '" name="roomId">\n' +
                '                                <a class="book-room-btn btn btn-primary">Chọn phòng</a>';
            $("#last-price-right").html(lastPriceRight);
        }
    }
)
;

(function () {
    'use strict';
    window.addEventListener('load', function () {
        // Fetch all the forms we want to apply custom Bootstrap validation styles to
        var forms = document.getElementsByClassName('needs-validation');
        // Loop over them and prevent submission
        var validation = Array.prototype.filter.call(forms, function (form) {
            form.addEventListener('submit', function (event) {
                if (form.checkValidity() === false) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    }, false);
})();
