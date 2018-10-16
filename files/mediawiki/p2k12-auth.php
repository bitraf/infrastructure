<?php

require_once dirname( __FILE__ ) . '/../includes/AuthPlugin.php';

class p2k12Auth extends AuthPlugin
{
  public $data;

  function allowPasswordChange() {
    return false;
  }

  function loadData() {
    if (isset($this->data))
      return true;

    $tmp = @file_get_contents('https://p2k16.bitraf.no/passwd.php');

    if ($tmp === false)
    {
      /* XXX: Report error */

      return false;
    }

    $tmp = explode("\n", $tmp);

    $this->data = array();

    foreach ($tmp as $line)
    {
      $line = explode(":", $line);
      $this->data[strtolower($line[0])] = $line;
    }

    return true;
  }

  function userExists($username) {
    if (!$this->loadData())
      return false;

    return array_key_exists(strtolower($username), $this->data);
  }

  function authenticate($username, $password) {
    $username = strtolower($username);

    if (!$this->loadData())
      return false;

    if (!array_key_exists($username, $this->data))
      return false;

    $pwent = $this->data[$username];
    $provided_hash = crypt($password, $pwent[1]);

    return ($provided_hash === $pwent[1]);
  }

  function autoCreate() {
    return true;
  }

  function strict() {
    return true;
  }

  function initUser(&$user, $autocreate=false) {
    $username = strtolower($username);

    if (!$this->loadData())
      return false;

    if (!array_key_exists($username, $this->data))
      return false;

    $pwent = $this->data[$username];

    $user->setRealName($pwent[4]);
    $user->setEmail("{$username}@bitraf.no");
    $user->mEmailAuthenticated = wfTimestampNow();
    $user->setOption('enotifwatchlistpages', 1);
    $user->setOption('enotifusertalkpages', 1);
    $user->setOption('enotifminoredits', 1);
    $user->setOption('enotifrevealaddr', 1);
  }
}
