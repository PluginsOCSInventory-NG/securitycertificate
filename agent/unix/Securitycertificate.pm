package Ocsinventory::Agent::Modules::Securitycertificate;

sub new {
    my $name="securitycertificate";

    my (undef,$context) = @_;
    my $self = {};

    $self->{logger} = new Ocsinventory::Logger ({
        config => $context->{config}
    });

    $self->{logger}->{header}="[$name]";

    $self->{context}=$context;

    $self->{structure}= {
                        name => $name,
                        start_handler => undef,    #or undef if don't use this hook
                        prolog_writer => undef,    #or undef if don't use this hook
                        prolog_reader => undef,    #or undef if don't use this hook
                        inventory_handler => $name."_inventory_handler",    #or undef if don't use this hook
                        end_handler => undef    #or undef if don't use this hook
    };

    bless $self;
}

sub securitycertificate_inventory_handler {
    my $self = shift;
    my $logger = $self->{logger};

    my $common = $self->{context}->{common};

    # Debug log for inventory
    $logger->debug("Starting securitycertificate inventory plugin");

    my $directory = '/etc/ssl/certs/';
    my @lines;

    opendir (DIR, $directory) or die $!;

    while (my $certificate = readdir(DIR)) {
        if (-f "$directory$certificate") {
            my @infos="openssl x509 -in $directory$certificate -text";

            if (index ($certificate, ".") != -1) {
                my $content = `@infos`;
                @lines = split('\n', $content);
            }

            my $issuer;
            my $datestart;
            my $dateend;

            foreach my $line (@lines) {
                if (index ($line, "Issuer:") != -1) {
                    $issuer = substr($line, index ($line, "Issuer:") + 8);
                }
                if (index($line, "Not Before:") != -1) {
                    $datestart = substr($line, index ($line, "Not Before:") + 12);
                }
                if (index($line, "Not After :") != -1)  {
                    $dateend = substr($line, index ($line, "Not After :") + 12);
                }
            }
            if ($issuer ne "" || $datestart ne "" || $dateend ne "") {
                push @{$common->{xmltags}->{SECURITYCERTIFICATE}},
                {
                    NAME => [$certificate],
                    AUTORITY => [$issuer],
                    DATESTART => [$datestart],
                    EXPIRATION => [$dateend],
                };
                $issuer = $datestart = $dateend = undef;
            }
        }
    }

}

1;
