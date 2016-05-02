# ASI Rewards

[![Build
Status](https://travis-ci.org/impactservices/asirewards.svg?branch=master)](https://travis-ci.org/impactservices/asirewards)
[![Code
Climate](https://codeclimate.com/github/impactservices/asirewards/badges/gpa.svg)](https://codeclimate.com/github/impactservices/asirewards)

ASI Rewards was created to help promoters issue travel and incentive certificates
to their customers without having to print and distribute physical certificates.

The client uses this application to create and design their own certificates
and distribute them to the end users. The end user will then activate their
certificate, and submit their booking request, or service request online, and
also make payment, if applicable, for the service or promotion they have
selected.

The system allows the client to monitor all activity of certificates sent from
the site, and monitor which clients have opened, viewed or activated their
certificate so that they can follow up and adjust sales and marketing efforts
to best engage the end users.

The system charge the client per certificate issued. Impact Services can also be
engaged to take and process booking or service requests at an additional fee.



## Development

We are following Sandi Metz's Rules for this application, you can read the
[description of the rules here]
(http://robots.thoughtbot.com/post/50655960596/sandi-metz-rules-for-developers). All new code should follow these rules. If you make changes in a pre-existing
file that violates these rules you should fix the violations as part of
your contribution.


### Setup

1. Clone the repository.

        % git clone git@github.com:impactservices/asirewards.git

2. Setup your environment.

        % bin/setup

3. Setup environment variables.

        % cp .sample.env .env
        % vim .env

4. Start application server.

        % bin/rails server

5. Verify that application is running.

        % open http://localhost:3000

## Contributing

First, thank you for contributing! We love pull requests from everyone. By
participating in this project, you hereby grant to Impact Services Co Ltd with the
right to grant or transfer an unlimited number of non exclusive licenses or
sub-licenses to third parties, under the copyright covering the contribution to
use the contribution by all means .

Here are a few technical guidelines to follow:

1. Open an [issue][issues] to discuss a new feature.
1. Write tests to support your new feature.
1. Make sure the entire test suite passes locally and on CI.
1. Open a Pull Request.
1. [Squash your commits][squash] after receiving feedback.
1. Party!

[issues]: https://github.com/impactservices/asirewards/issues
[squash]: https://github.com/thoughtbot/guides/tree/master/protocol/git#write-a-feature

## Credits

<img src="https://www.impactservices.io/images/logo-impact-services.png" width="266" alt="Impact Services Co. Ltd.">

This application is developed, maintained and funded by [Impact Services Co.
Ltd.] (https://www.impactservices.co.th)

Thank you to all [the contributors]
(https://github.com/impactservices/asirewards/graphs/contributors)
