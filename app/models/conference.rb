# -*- coding: utf-8 -*-
class Conference < ActiveRecord::Base
  attr_accessible :applicant, :call, :conference_url, :date, :description, :document_url, :email, :funding, :host, :length, :name, :received_on

  has_many :fundings, :dependent => :destroy
  has_many :transactions, :through => :fundings

  def to_s
    name
  end

  def first_day 
    date
  end

  def last_day
    date + (length - 1)
  end

  def dates
    "#{first_day}" + (length > 1 ? " - #{last_day}" : "")
  end

  def applicant_first
    applicant.split.first
  end

  # FIXME: these letters should really be erb templates ...
  def approval_letter
    <<LETTER
Dear #{applicant_first},

Thank you very much for your recent application to the IMS 
asking for support of your conference 
'#{name}'.  
The Committee has now carefully evaluated your application, 
and I am pleased to be able to inform you that 
the IMS will support your event with €#{funding}.  
Please let me have your bank details as soon as possible 
so that the funds can be transferred without delay.

Please note that the IMS in return expects 
a report on the academic activities during your meeting 
to be sent to the Editor of the IMS Bulletin at

   ims.bulletin@gmail.com 

in due course.  Sample reports can be found in recent 
issues of the Bulletin on the Society's website at

   http://www.maths.tcd.ie/pub/ims/bulletin/index.php

The IMS wishes your meeting every success.

Best regards,
Goetz Pfeiffer
(Treasurer, IMS)
LETTER
  end

  def rejection_letter
    <<LETTER
Dear #{applicant_first},

Thank you very much for your recent application to the IMS 
asking for support of your conference 
'#{name}'.  
The Committee has now carefully evaluated your application, 
and I regret to have to inform you that 
the IMS will not support your event on this occasion.  

The IMS budget is extremely limited and we had to make 
the difficult decision whether to fund many applications
with very small amounts or to support fewer with reasonable sums.  
Our decision should not be interpreted as a negative view 
on your event for which the IMS wishes you every success.

Best regards,
Goetz Pfeiffer
(Treasurer, IMS)
LETTER
  end
end
